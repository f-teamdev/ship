import 'package:shelf_modular/shelf_modular.dart';

import '../domain/repositories/user_repository.dart';
import '../domain/usecases/create_user.dart';
import '../domain/usecases/update_password.dart';
import '../domain/usecases/update_user.dart';
import '../external/datasources/user_datasource_datasource.dart';
import '../infra/datasources/user_datasource.dart';
import '../infra/repositories/user_repository.dart';

class UserModule extends Module {
  @override
  List<Bind> get binds => [
        // external
        Bind.factory<UserDatasource>((i) => UserDatasourceImpl(i())),
        // infra
        Bind.factory<UserRepository>((i) => UserRepositoryImpl(i())),
        // domain
        Bind.factory<CreateUser>((i) => CreateUserImpl(i())),
        Bind.factory<UpdatePassword>((i) => UpdatePasswordImpl(i())),
        Bind.factory<UpdateUser>((i) => UpdateUserImpl(i())),
        // presenter
      ];
}
