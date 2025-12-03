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

@DriftDatabase(tables: [UserSettings])
class AllergenDatabase extends _$AllergenDatabase {
  AllergenDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ----- Convenience methods for allergens ----- //

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
  // ignore: unintended_html_in_doc_comment
  /// R: List<String> - the allergens in our database
  /// P: N/A
  Future<List<String>> getAllergens() async {
    final row = await _getOrCreateSettingsRow();
    return row.allergens;
  }

  /// B: Updates the allergens in our database
  /// E: N/A
  /// R: N/A
  // ignore: unintended_html_in_doc_comment
  /// P: List<String> list - the list of allergens we are updating our database with
  Future<void> setAllergens(List<String> list) async {
    final row = await _getOrCreateSettingsRow();
    await (update(userSettings)..where((t) => t.id.equals(row.id))).write(
      UserSettingsCompanion(allergens: Value(list)),
    );
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
