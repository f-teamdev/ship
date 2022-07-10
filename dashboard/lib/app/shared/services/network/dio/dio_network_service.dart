import 'package:dio/dio.dart';

import '../network_exception.dart';
import '../network_response.dart';
import '../network_service.dart';

class DioNetworkService implements NetworkService {
  final Dio _dio;

  DioNetworkService(this._dio);

  @override
  Future<NetworkResponse> get(String path, {bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.get(path,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        type: NetworkExceptionType.values.firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> delete(String path, {bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.delete(path,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        type: NetworkExceptionType.values.firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> patch(String path, {data, bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.patch(path,
          data: data,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        type: NetworkExceptionType.values.firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> post(String path, {data, bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.post(path,
          data: data,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        type: NetworkExceptionType.values.firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> put(String path, {data, bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _dio.put(path,
          data: data,
          options: Options(
            validateStatus: validateStatus,
            headers: headers,
            responseType: ResponseType.json,
          ));
      return NetworkResponse(response.data, response.statusCode);
    } on DioError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        type: NetworkExceptionType.values.firstWhere((type) => type.name == e.type.name),
        statusCode: e.response?.statusCode ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }
}
