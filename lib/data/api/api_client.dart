import 'package:dio/dio.dart';
import 'package:places/data/api/api_constants.dart';

class ApiClient {
  final _baseOptions = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000,
    sendTimeout: 5000,
    responseType: ResponseType.json,
  );
  
  Dio get client => Dio(_baseOptions);
}
