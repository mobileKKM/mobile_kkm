import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Where the user's profile photo comes from. The URL in `UserData.photoUrl`
/// is public, so no session is involved.
abstract class PhotoCache {
  ImageProvider image(String url);

  /// Forgets every stored photo.
  Future<void> clear();
}

/// [PhotoCache] over the network, kept on disk between runs.
class NetworkPhotoCache implements PhotoCache {
  const NetworkPhotoCache();

  @override
  ImageProvider image(String url) => CachedNetworkImageProvider(url);

  // The photo is all the app keeps in the default cache.
  @override
  Future<void> clear() => DefaultCacheManager().emptyCache();
}
