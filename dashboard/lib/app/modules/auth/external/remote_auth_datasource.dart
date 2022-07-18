import '../../../shared/constants/constants.dart';
import '../../../shared/services/network/network_exception.dart';
import '../../../shared/services/network/network_service.dart';
import '../domain/exceptions/exceptions.dart';
import '../infra/datasources/auth_datasource.dart';

class RemoteAuthDatasource implements AuthDatasource {
  final NetworkService network;

  RemoteAuthDatasource(this.network);
  @override
  Future login(String credentials) async {
    try {
      final response = await network.get('/auth/login', headers: {
        NO_AUTHORIZATION: '',
        'Authorization': 'basic $credentials',
      });
      return response.data;
    } on NetworkException catch (e, s) {
      if (e.data != null) {
        throw AuthException(e.data['error'], s, e);
      }
      throw AuthException(e.message, s);
    }
  }

  @override
  Future refreshToken(String token) async {
    try {
      final response = await network.get('/auth/refresh_token', headers: {
        NO_AUTHORIZATION: '',
        'Authorization': 'bearer $token',
      });
      return response.data;
    } on NetworkException catch (e, s) {
      throw AuthException(e.message, s, e);
    }
  }

  @override
  Future checkToken(String accessToken) async {
    try {
      final response = await network.get('/auth/check_token', headers: {
        NO_AUTHORIZATION: '',
        'Authorization': 'bearer $accessToken',
      });
      return response.data;
    } on NetworkException catch (e, s) {
      throw AuthException(e.message, s, e);
    }
  }
}
