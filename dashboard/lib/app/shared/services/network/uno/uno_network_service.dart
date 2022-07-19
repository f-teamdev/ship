import 'package:dio/dio.dart';
import 'package:uno/uno.dart';

import '../network_exception.dart';
import '../network_response.dart';
import '../network_service.dart';

class UnoNetworkService implements NetworkService {
  final Uno _uno;

  UnoNetworkService(this._uno);

  @override
  Future<NetworkResponse> get(String path, {bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _uno.get(
        path,
        headers: headers,
        validateStatus: validateStatus,
      );
      return NetworkResponse(response.data, response.status);
    } on UnoError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        statusCode: e.response?.status ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> delete(String path, {bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _uno.delete(
        path,
        headers: headers,
        validateStatus: validateStatus,
      );
      return NetworkResponse(response.data, response.status);
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
      final response = await _uno.patch(
        path,
        data: data,
        headers: headers,
        validateStatus: validateStatus,
      );
      return NetworkResponse(response.data, response.status);
    } on UnoError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        statusCode: e.response?.status ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> post(String path, {data, bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _uno.post(
        path,
        data: data,
        headers: headers,
        validateStatus: validateStatus,
      );
      return NetworkResponse(response.data, response.status);
    } on UnoError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        statusCode: e.response?.status ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<NetworkResponse> put(String path, {data, bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}}) async {
    try {
      final response = await _uno.put(
        path,
        data: data,
        headers: headers,
        validateStatus: validateStatus,
      );
      return NetworkResponse(response.data, response.status);
    } on UnoError catch (e) {
      throw NetworkException(
        e.message,
        e.response?.data,
        statusCode: e.response?.status ?? 500,
        stackTrace: e.stackTrace,
      );
    }
  }
}
