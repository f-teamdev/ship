import 'package:ship_dashboard/app/modules/auth/domain/exceptions/exceptions.dart';
import 'package:ship_dashboard/app/modules/auth/infra/datasources/auth_datasource.dart';

import '../../../shared/services/network/network_exception.dart';
import '../../../shared/services/network/network_service.dart';

class RemoteAuthDatasource implements AuthDatasource {
  final NetworkService network;

  RemoteAuthDatasource(this.network);
  @override
  Future login(String credentials) async {
    try {
      final response = await network.get('/auth/login', headers: {
        'no-interceptors': '',
        'Authorization': 'basic $credentials',
      });
      return response.data;
    } on NetworkException catch (e, s) {
      throw AuthException(e.message, s);
    }
  }
}
