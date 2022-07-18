import '../../../shared/services/network/network_exception.dart';
import '../../../shared/services/network/network_service.dart';
import '../domain/exceptions/exceptions.dart';
import '../infra/datasources/user_datasource.dart';

class RemoteUserDatasource implements UserDatasource {
  final NetworkService network;

  RemoteUserDatasource(this.network);

  @override
  Future getLoggedUser() async {
    try {
      final response = await network.get('/logged_user');
      return response.data;
    } on NetworkException catch (e, s) {
      if (e.data != null) {
        throw UserException(e.data['error'], s);
      }
      throw UserException(e.message, s);
    }
  }
}
