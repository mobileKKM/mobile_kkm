import 'package:dio/dio.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:test/test.dart';

void main() {
  group('EkpApiException.fromDio', () {
    test('401 with body becomes EkpUnauthorizedException carrying the code', () {
      final e = EkpApiException.fromDio(
        DioException(
          requestOptions: RequestOptions(path: '/x'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/x'),
            data: {'code': 5, 'message': 'Sesja wygasła'},
          ),
        ),
      );
      expect(e, isA<EkpUnauthorizedException>());
      expect(e.statusCode, 401);
      expect(e.message, 'Sesja wygasła');
      expect(e.codeAsInt, 5);
    });

    test('tickets-history 400 shape maps exceptionCode + errorToken', () {
      final e = EkpApiException.fromDio(
        DioException(
          requestOptions: RequestOptions(path: '/api/v1/tickets'),
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: '/api/v1/tickets'),
            data: {
              'exceptionCode': 1,
              'message': 'Przepraszamy, wystąpił błąd...',
              'errorToken': 'c5f63528-5943-4bc4-8f79-c362da56b6cd',
            },
          ),
        ),
      );
      expect(e, isA<EkpHttpException>());
      expect(e.codeAsInt, 1);
      expect(e.errorToken, 'c5f63528-5943-4bc4-8f79-c362da56b6cd');
      expect(e.toString(), contains('c5f63528-5943-4bc4-8f79-c362da56b6cd'));
    });

    test('string codes are kept as strings', () {
      final e = EkpApiException.fromDio(
        DioException(
          requestOptions: RequestOptions(path: '/x'),
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: '/x'),
            data: {'code': 'PasswordInHistory', 'message': '...'},
          ),
        ),
      );
      expect(e.codeAsString, 'PasswordInHistory');
      expect(e.codeAsInt, isNull);
    });

    test('no response becomes EkpNetworkException', () {
      final e = EkpApiException.fromDio(
        DioException(
          requestOptions: RequestOptions(path: '/x'),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      expect(e, isA<EkpNetworkException>());
      expect((e as EkpNetworkException).cause, isA<DioException>());
    });

    test('non-map bodies do not crash', () {
      final e = EkpApiException.fromDio(
        DioException(
          requestOptions: RequestOptions(path: '/x'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/x'),
            data: 'Internal Server Error',
          ),
        ),
      );
      expect(e, isA<EkpHttpException>());
      expect(e.statusCode, 500);
      expect(e.message, isNull);
    });

    test('embedded EkpApiException passes through unchanged', () {
      const embedded = EkpSessionExpiredException(message: 'x');
      final e = EkpApiException.fromDio(
        DioException(
          requestOptions: RequestOptions(path: '/x'),
          error: embedded,
        ),
      );
      expect(e, same(embedded));
    });
  });
}
