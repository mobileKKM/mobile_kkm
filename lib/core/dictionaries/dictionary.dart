import 'package:ekp_api/ekp_api.dart';

/// One of the `dictionary/*` lists: how to get it from the server and how to
/// put it into, and take it out of, the `DictionaryCache`.
class Dictionary<T> {
  const Dictionary({required this.name, required this.fetch, required this.fromJson, required this.toJson});

  /// The file name in the cache, without extension.
  final String name;
  final Future<T> Function(EkpClient client) fetch;
  final T Function(Map<String, dynamic> json) fromJson;
  final Map<String, dynamic> Function(T value) toJson;

  static final ticketKinds = Dictionary<TicketKindListResponse>(
    name: 'ticket-kind-list',
    fetch: (client) => client.dictionaries.ticketKindList(),
    fromJson: TicketKindListResponse.fromJson,
    toJson: (value) => value.toJson(),
  );

  static final ticketLineScopes = Dictionary<TicketNumberOfLineListResponse>(
    name: 'ticket-number-of-line-list',
    fetch: (client) => client.dictionaries.ticketNumberOfLineList(),
    fromJson: TicketNumberOfLineListResponse.fromJson,
    toJson: (value) => value.toJson(),
  );

  static final ticketPeriods = Dictionary<TicketPeriodListResponse>(
    name: 'ticket-period-list',
    fetch: (client) => client.dictionaries.ticketPeriodList(),
    fromJson: TicketPeriodListResponse.fromJson,
    toJson: (value) => value.toJson(),
  );

  static final cityCardTypes = Dictionary<CityCardTypesResponse>(
    name: 'city-card-types',
    fetch: (client) => client.dictionaries.cityCardTypes(),
    fromJson: CityCardTypesResponse.fromJson,
    toJson: (value) => value.toJson(),
  );
}
