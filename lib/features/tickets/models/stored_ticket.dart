import 'package:ekp_api/ekp_api.dart';

/// A mobile ticket as held in the on-device database.
class StoredTicket {
  const StoredTicket(this.ticket, {this.pinned = false});

  final MkkmTicket ticket;

  /// Pinned to the home screen by the user.
  final bool pinned;
}
