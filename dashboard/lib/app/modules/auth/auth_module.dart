import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_triple_bind/modular_triple_bind.dart';

import 'auth_page.dart';
import 'domain/usecases/check_token.dart';
import 'domain/usecases/get_tokenization.dart';
import 'domain/usecases/login.dart';
import 'domain/usecases/logout.dart';
import 'domain/usecases/refresh_token.dart';
import 'domain/usecases/save_tokenization.dart';
import 'external/remote_auth_datasource.dart';
import 'infra/repositories/auth_repository.dart';
import 'infra/repositories/secure_storage_repository.dart';
import 'presentation/stores/auth_store.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        // domain
        Bind.factory((i) => GetTokenizationImpl(i()), export: true),
        Bind.factory((i) => SaveTokenizationImpl(i()), export: true),
        Bind.factory((i) => LoginImpl(i()), export: true),
        Bind.factory((i) => LogoutImpl(i()), export: true),
        Bind.factory((i) => RefreshTokenImpl(i()), export: true),
        Bind.factory((i) => CheckTokenImpl(i()), export: true),
        // infra
        Bind.factory((i) => SecureStorageRepositoryImpl(i(), i()), export: true),
        Bind.factory((i) => AuthRepositoryImpl(i()), export: true),
        // external
        Bind.factory((i) => RemoteAuthDatasource(i()), export: true),
        // presentation
        TripleBind.singleton((i) => AuthStore(i(), i(), i(), i(), i(), i()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const AuthPage()),
      ];
}
