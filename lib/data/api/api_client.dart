import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/ui/res/constants.dart' as constants;

class ApiClient {
  final _baseOptions = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000,
    sendTimeout: 5000,
  );

  Dio get client {
    final _dio = Dio(_baseOptions);

    return addInterceptors(_dio);
  }

  ApiClient();

  Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, requestInterceptorHandler) {
            debugPrint(constants.textRequestIsSent);

            return requestInterceptorHandler.next(request);
          },
          onResponse: (response, responseInterceptorHandler) {
            debugPrint('Получен ответ');

            return responseInterceptorHandler.next(response);
          },
          onError: (error, errorInterceptorHandler) {
            debugPrint(NetworkException.fromDioError(error).toString());

            return errorInterceptorHandler.next(error);
          },
        ),
      );
  }
}
