import 'dart:convert';
import 'dart:io';

/// A dictionary as it was stored, and when the server last sent it.
class CachedDictionary {
  const CachedDictionary(this.json, this.fetchedAt);

  final Map<String, dynamic> json;
  final DateTime fetchedAt;
}

/// On-device copies of the `dictionary/*` lists, so the names for type codes
/// are there at once and without a connection.
abstract class DictionaryCache {
  Future<CachedDictionary?> read(String name);
  Future<void> write(String name, Map<String, dynamic> json, DateTime fetchedAt);
}

/// [DictionaryCache] as one JSON file per dictionary in [_directory]:
/// `{"fetchedAt": "<ISO-8601 UTC>", "data": {…}}`. The content is public
/// reference data, so plain files will do.
class FileDictionaryCache implements DictionaryCache {
  FileDictionaryCache(this._directory);

  final Directory _directory;

  File _file(String name) => File('${_directory.path}${Platform.pathSeparator}$name.json');

  @override
  Future<CachedDictionary?> read(String name) async {
    try {
      final stored = jsonDecode(await _file(name).readAsString()) as Map<String, dynamic>;
      return CachedDictionary(stored['data'] as Map<String, dynamic>, DateTime.parse(stored['fetchedAt'] as String));
    } catch (_) {
      // Missing, cut short or from another shape: behave as a cache miss.
      return null;
    }
  }

  @override
  Future<void> write(String name, Map<String, dynamic> json, DateTime fetchedAt) async {
    await _directory.create(recursive: true);
    final file = _file(name);
    // Written beside the target and renamed over it, so a write that is cut
    // short never leaves half a file under the real name.
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString(
      jsonEncode({'fetchedAt': fetchedAt.toUtc().toIso8601String(), 'data': json}),
      flush: true,
    );
    await temporary.rename(file.path);
  }
}
