import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio(baseOptions);

BaseOptions baseOptions = BaseOptions(
  //baseUrl: 'https://test-backend-flutter.surfstudio.ru/',
  baseUrl: 'https://jsonplaceholder.typicode.com/',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
  responseType: ResponseType.json,
);

Future<dynamic> getUsers() async {
  initInterceptors();

  final postResponse = await dio.get<dynamic>('/users');

  if (postResponse.statusCode == 200) {
    return postResponse.data;
  }

  throw Exception('HTTP request error. Error code ${postResponse.statusCode}');
}

void initInterceptors() {
  dio.interceptors.add(InterceptorsWrapper(
    onError: (error, errorInterceptorHandler) {},
    onRequest: (request, requestInterceptorHandler) {
      debugPrint('Запрос отправляется');
      return requestInterceptorHandler.next(request);
    },
    onResponse: (response, responseInterceptorHandler) {
      debugPrint('Получен ответ');
      return responseInterceptorHandler.next(response);
    },
  ));
}
