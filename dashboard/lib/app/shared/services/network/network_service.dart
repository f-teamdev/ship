import 'network_response.dart';

abstract class NetworkService {
  Future<NetworkResponse> get(String path, {bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}});
  Future<NetworkResponse> delete(String path, {bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}});
  Future<NetworkResponse> post(String path, {dynamic data, bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}});
  Future<NetworkResponse> put(String path, {dynamic data, bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}});
  Future<NetworkResponse> patch(String path, {dynamic data, bool Function(int? statusCode)? validateStatus, Map<String, String> headers = const {}});
}
