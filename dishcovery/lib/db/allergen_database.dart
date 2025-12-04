import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'string_list_converter.dart';

part 'allergen_database.g.dart';

/// Table to store user settings, including allergens
class UserSettings extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Stores List<String> as JSON text in SQLite using StringListConverter
  TextColumn get allergens => text().map(const StringListConverter())();
}

/// Table to store restaurant-related settings, currently just a list of
/// restaurant IDs (e.g., favorites).
class RestaurantSettings extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Stores List<String> restaurant IDs as JSON in a single column
  TextColumn get restaurantIds =>
      text().map(const StringListConverter())();
}

@DriftDatabase(tables: [UserSettings, RestaurantSettings])
class AllergenDatabase extends _$AllergenDatabase {
  AllergenDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  // Allergen helpers

  /// B: Assures the user only has one row, and if it is empty,
  ///     it creates one for them. We do this to avoid the case where we retrieve
  ///     allergen data from the start before user has made any changes to their
  ///     account.
  /// E: N/A
  /// R: UserSetting - the row from the table we created above
  ///     (complete with an id and a TextColumn of user allergens)
  /// P: N/A
  Future<UserSetting> _getOrCreateSettingsRow() async {
    final rows = await select(userSettings).get();
    if (rows.isNotEmpty) return rows.first;

    final id = await into(
      userSettings,
    ).insert(UserSettingsCompanion(allergens: const Value(<String>[])));

    return (await (select(
      userSettings,
    )..where((t) => t.id.equals(id))).getSingle());
  }

  /// B: Returns the allergens in our database
  /// E: N/A
  //// ignore: unintended_html_in_doc_comment
  /// R: List<String> - the allergens in our database
  /// P: N/A
  Future<List<String>> getAllergens() async {
    final row = await _getOrCreateSettingsRow();
    return row.allergens;
  }

  /// B: Updates the allergens in our database
  /// E: N/A
  /// R: N/A
  //// ignore: unintended_html_in_doc_comment
  /// P: List<String> list - the list of allergens we are updating our database with
  Future<void> setAllergens(List<String> list) async {
    final row = await _getOrCreateSettingsRow();
    await (update(userSettings)..where((t) => t.id.equals(row.id))).write(
      UserSettingsCompanion(allergens: Value(list)),
    );
  }

  // Restaurant helpers

  /// B: Ensures there is exactly one row in RestaurantSettings, creating it
  ///    if necessary. Mirrors _getOrCreateSettingsRow for allergens.
  /// E: N/A
  /// R: RestaurantSetting - the single settings row for restaurant IDs
  /// P: N/A
  Future<RestaurantSetting> _getOrCreateRestaurantSettingsRow() async {
    final rows = await select(restaurantSettings).get();
    if (rows.isNotEmpty) return rows.first;

    final id = await into(restaurantSettings).insert(
      RestaurantSettingsCompanion(restaurantIds: const Value(<String>[])),
    );

    return (await (select(restaurantSettings)
          ..where((t) => t.id.equals(id)))
        .getSingle());
  }

  /// B: Returns the list of saved restaurant IDs (e.g., favorites)
  /// E: N/A
  /// ignore: unintended_html_in_doc_comment
  /// R: List<String> - restaurant IDs stored in the database
  /// P: N/A
  Future<List<String>> getRestaurantIds() async {
    final row = await _getOrCreateRestaurantSettingsRow();
    return row.restaurantIds;
  }

  /// B: Replaces the list of saved restaurant IDs with ids
  /// E: N/A
  /// R: N/A
  /// ignore: unintended_html_in_doc_comment
  /// P: List<String> ids - the new list of restaurant IDs to persist
  Future<void> setRestaurantIds(List<String> ids) async {
    final row = await _getOrCreateRestaurantSettingsRow();
    await (update(restaurantSettings)..where((t) => t.id.equals(row.id)))
        .write(
      RestaurantSettingsCompanion(restaurantIds: Value(ids)),
    );
  }

  /// B: Adds id to the list if it's not present, removes it if it is.
  /// E: N/A
  /// R: N/A
  /// P: String id - the restaurant id to toggle
  Future<void> toggleRestaurantId(String id) async {
    final ids = await getRestaurantIds();
    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }
    await setRestaurantIds(ids);
  }
}

/// Lazily opens the database at a platform-specific path.
/// Documentation for this section:
/// https://pub.dev/documentation/drift/latest/drift/LazyDatabase-class.html
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'dishcovery.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
