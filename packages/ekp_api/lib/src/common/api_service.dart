import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../common/api_exception.dart';

/// Base class for the per-domain API services: holds the [Dio] instance and
/// translates [DioException]s into typed [EkpApiException]s.
abstract class EkpApiService {
  EkpApiService(this.dio);

  final Dio dio;

  /// Runs [fn], converting any [DioException] into an [EkpApiException].
  @protected
  Future<T> guard<T>(Future<T> Function() fn) async {
    try {
      return await fn();
    } on DioException catch (e) {
      throw EkpApiException.fromDio(e);
    }
  }
}
