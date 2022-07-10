import 'package:flutter_modular/flutter_modular.dart';
import 'package:ship_dashboard/app/modules/auth/domain/usecases/get_tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/usecases/login.dart';
import 'package:ship_dashboard/app/modules/auth/domain/usecases/refresh_token.dart';
import 'package:ship_dashboard/app/modules/auth/domain/usecases/save_tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/external/remote_auth_datasource.dart';
import 'package:ship_dashboard/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:ship_dashboard/app/modules/auth/infra/repositories/secure_storage_repository.dart';
import 'package:ship_dashboard/app/modules/auth/presentation/stores/auth_store.dart';

import 'auth_page.dart';
import 'domain/usecases/logout.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        // domain
        Bind.factory((i) => GetTokenizationImpl(i()), export: true),
        Bind.factory((i) => SaveTokenizationImpl(i()), export: true),
        Bind.factory((i) => LoginImpl(i()), export: true),
        Bind.factory((i) => LogoutImpl(i()), export: true),
        Bind.factory((i) => RefreshTokenImpl(i()), export: true),
        // infra
        Bind.factory((i) => SecureStorageRepositoryImpl(i(), i()), export: true),
        Bind.factory((i) => AuthRepositoryImpl(i()), export: true),
        // external
        Bind.factory((i) => RemoteAuthDatasource(i()), export: true),
        // presentation
        Bind.singleton((i) => AuthStore(i(), i(), i(), i(), i()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => AuthPage()),
      ];
}
