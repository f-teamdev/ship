import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ship_dashboard/app/modules/splash/splash_page.dart';
import 'package:ship_dashboard/app/shared/services/encrypt/encrypt_service.dart';
import 'package:ship_dashboard/app/shared/services/network/dio/dio_auth_interceptor.dart';

import 'modules/auth/auth_module.dart';
import 'modules/auth/presentation/stores/auth_store.dart';
import 'modules/home/home_module.dart';
import 'modules/user/user_module.dart';
import 'shared/constants/constants.dart';
import 'shared/services/local_storage/local_storage_service.dart';
import 'shared/services/network/dio/dio_network_service.dart';
import 'shared/services/network/network_service.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        AuthModule(),
        UserModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.factory((i) => EncryptService()),
        Bind.factory((i) => LocalStorage()),
        Bind.factory<NetworkService>((i) => DioNetworkService(i())),
        Bind.singleton<Dio>((i) {
          final options = BaseOptions(baseUrl: URL_BASE);
          final dio = Dio(options);
          dio.interceptors.add(DioAuthInterceptor(() {
            return i<AuthStore>();
          }, dio));
          return dio;
        }),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => SplashScreen()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
