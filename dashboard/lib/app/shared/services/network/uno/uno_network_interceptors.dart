import 'package:flutter_modular/flutter_modular.dart';
import 'package:uno/uno.dart';

import '../../../../modules/auth/presentation/states/auth_state.dart';
import '../../../../modules/auth/presentation/stores/auth_store.dart';
import '../../../constants/constants.dart';

bool checkNoAuthorizationHeader(Request request) {
  final authStore = Modular.get<AuthStore>();
  return !request.headers.containsKey(NO_AUTHORIZATION) && authStore.state is Logged;
}

Future<Request> onRequest(Request request) async {
  final authStore = Modular.get<AuthStore>();
  final tokenization = (authStore.state as Logged).tokenization;
  request.headers['authorization'] = 'bearer ${tokenization.accessToken}';
  return request;
}

Future<dynamic> onError(UnoError err) async {
  final authStore = Modular.get<AuthStore>();
  final request = err.request;

  if (request == null) {
    return err;
  }

  final containRefreshTokenInHeader = request.headers.containsKey(REFRESHED_TOKEN);

  if (err.response?.status == 403 && !containRefreshTokenInHeader) {
    await authStore.refreshToken();
    if (authStore.state is! Logged) {
      return err;
    }

    request.headers[REFRESHED_TOKEN] = '';

    final uno = Modular.get<Uno>();

    try {
      final response = await uno.request(request);
      return response;
    } on UnoError catch (e) {
      return e;
    }
  } else if (containRefreshTokenInHeader) {
    authStore.logout();
  }

  return err;
}
