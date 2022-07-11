import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_triple_bind/modular_triple_bind.dart';
import 'package:ship_dashboard/app/modules/user/domain/usecases/logged_user.dart';
import 'package:ship_dashboard/app/modules/user/external/remote_user_datasource.dart';
import 'package:ship_dashboard/app/modules/user/infra/repositories/user_repository.dart';
import 'package:ship_dashboard/app/modules/user/presentation/stores/logged_user_store.dart';

class UserModule extends Module {
  @override
  List<Bind> get binds => [
        // domain
        Bind.factory((i) => LoggedUserImpl(i()), export: true),
        // infra
        Bind.factory((i) => UserRepositoryImpl(i()), export: true),
        // external
        Bind.factory((i) => RemoteUserDatasource(i()), export: true),
        // presentation
        TripleBind.singleton((i) => LoggedUserStore(i()), export: true),
      ];
}
