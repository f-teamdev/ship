import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uno/uno.dart';

import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'modules/splash/splash_page.dart';
import 'modules/user/user_module.dart';
import 'shared/constants/constants.dart';
import 'shared/services/encrypt/encrypt_service.dart';
import 'shared/services/local_storage/local_storage_service.dart';
import 'shared/services/network/network_service.dart';
import 'shared/services/network/uno/uno_network_interceptors.dart';
import 'shared/services/network/uno/uno_network_service.dart';

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
        // Bind.singleton<Dio>((i) {
        //   final options = BaseOptions(baseUrl: URL_BASE);
        //   final dio = Dio(options);
        //   dio.interceptors.add(DioAuthInterceptor(dio));
        //   return dio;
        // }),
        //Bind.factory<NetworkService>((i) => DioNetworkService(i())),

        Bind.singleton<Uno>((i) {
          final uno = Uno(baseURL: URL_BASE);
          uno.interceptors.request.use(onRequest, runWhen: checkNoAuthorizationHeader);
          uno.interceptors.response.use(id, onError: onError);
          return uno;
        }),
        Bind.factory<NetworkService>((i) => UnoNetworkService(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreen()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
