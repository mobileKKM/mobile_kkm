import 'dart:convert';
import 'dart:io';

import 'package:mobile_kkm/core/crypto/aztec_key.dart';

/// The last key the relay sent, kept on the device so that it is there at
/// once and without a connection.
abstract class AztecKeyStore {
  Future<AztecKey?> read();
  Future<void> write(AztecKey key);
}

/// [AztecKeyStore] as one JSON file. A public key, so a plain file will do.
class FileAztecKeyStore implements AztecKeyStore {
  FileAztecKeyStore(this._file);

  final File _file;

  @override
  Future<AztecKey?> read() async {
    try {
      return AztecKey.fromJson(jsonDecode(await _file.readAsString()) as Map<String, dynamic>);
    } catch (_) {
      // Missing, cut short or from another shape: there is none.
      return null;
    }
  }

  @override
  Future<void> write(AztecKey key) async {
    await _file.parent.create(recursive: true);
    // Written beside the target and renamed over it, so a write that is cut
    // short never leaves half a file under the real name.
    final temporary = File('${_file.path}.tmp');
    await temporary.writeAsString(jsonEncode(key.toJson()), flush: true);
    await temporary.rename(_file.path);
  }
}
