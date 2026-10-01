import 'dart:convert';
import 'dart:io';

/// Loads a sanitized fixture from `test/fixtures/`.
Map<String, dynamic> fixture(String name) {
  final file = File('test/fixtures/$name.json');
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

/// Loads a fixture whose top level is a JSON array.
List<dynamic> fixtureList(String name) {
  final file = File('test/fixtures/$name.json');
  return jsonDecode(file.readAsStringSync()) as List<dynamic>;
}
