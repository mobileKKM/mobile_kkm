import 'dart:io';

/// Whether the first start notice was accepted on this phone.
abstract class FirstStartStore {
  Future<bool> read();
  Future<void> markSeen();
}

/// [FirstStartStore] as an empty marker file. Nothing secret, and unlike the
/// keychain it goes with the app, so a reinstall is a first start again.
class FileFirstStartStore implements FirstStartStore {
  FileFirstStartStore(this._file);

  final File _file;

  @override
  Future<bool> read() async {
    try {
      return _file.existsSync();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> markSeen() async {
    await _file.parent.create(recursive: true);
    await _file.writeAsString('', flush: true);
  }
}
