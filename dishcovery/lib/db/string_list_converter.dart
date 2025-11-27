import 'dart:convert';
import 'package:drift/drift.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  /// B: Used to convert a long String from the database into 
  ///     a List of strings with JSON decode 
  /// E: N/A
  // ignore: unintended_html_in_doc_comment
  /// R: List<String> - the list of allergens the user has
  /// P: String fromDb - the long string we get from the DB
  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return List<String>.from(jsonDecode(fromDb));
  }

  /// B: Used to convert a List of strings from the user input into 
  ///     a long String to be stored in the drift database
  /// E: N/A
  // ignore: unintended_html_in_doc_comment
  /// R: String - the string stored in jsconEncode format
  // ignore: unintended_html_in_doc_comment
  /// P: List<String> value - the list of strings received from user checked boxes
  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}
