import 'package:dio/dio.dart';

class NetworkException implements Exception {
  late String message;

  NetworkException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.other:
        message = 'Connection to API server failed due to internet connection';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioErrorType.response:
        message =
            'В запросе ${dioError.response!.requestOptions.uri} возникла ошибка: ${dioError.response!.statusCode} ${dioError.response!.statusMessage}';
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }

  @override
  String toString() => message;
}
