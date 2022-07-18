abstract class AuthDatasource {
  Future login(String credentials);
  Future refreshToken(String token);
  Future checkToken(String accessToken);
}
