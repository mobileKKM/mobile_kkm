import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Where tPay's payment logos come from.
abstract class PaymentLogos {
  ImageProvider image(String url);
}

/// [PaymentLogos] over the network, kept on disk between runs in a cache
/// of their own: the default one is emptied with the profile photo.
class NetworkPaymentLogos implements PaymentLogos {
  NetworkPaymentLogos();

  static final _cache = CacheManager(Config('payment_logos', stalePeriod: const Duration(days: 30)));

  @override
  ImageProvider image(String url) => CachedNetworkImageProvider(url, cacheManager: _cache);
}
