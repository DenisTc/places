import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/api/api_constants.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/search_repository.dart';

final placeInteractor = PlaceInteractor(PlaceRepository());
final searchInteractor = SearchInteractor(SearchRepository());

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

  Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, requestInterceptorHandler) {
            debugPrint('Запрос отправляется');
            return requestInterceptorHandler.next(request);
          },
          onResponse: (response, responseInterceptorHandler) {
            debugPrint('Получен ответ');
            return responseInterceptorHandler.next(response);
          },
          onError: (error, errorInterceptorHandler) {
            debugPrint(NetworkException.fromDioError(error).toString());
            if (error.requestOptions.path == ApiConstants.placeUrl) {
              placeInteractor.addErrorToPlacesController(error);
            } else {
              searchInteractor.addErrorToFiltredController(error);
            }
            return errorInterceptorHandler.next(error);
          },
        ),
      );
  }
}
