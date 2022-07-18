import 'package:dio/dio.dart';

import '../../../../modules/auth/presentation/states/auth_state.dart';
import '../../../../modules/auth/presentation/stores/auth_store.dart';
import '../../../constants/constants.dart';

class DioAuthInterceptor extends Interceptor {
  final AuthStore Function() _authStoreLazy;
  final Dio _dio;

  DioAuthInterceptor(this._authStoreLazy, this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers.containsKey(NO_AUTHORIZATION)) {
      handler.next(options);
      return;
    }
    final authStore = _authStoreLazy();
    final state = authStore.state;
    if (state is Logged) {
      final tokenization = state.tokenization;
      options.headers['authorization'] = 'bearer ${tokenization.accessToken}';
    }

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final authStore = _authStoreLazy();

    if (err.response?.statusCode == 403 && !err.requestOptions.headers.containsKey(REFRESHED_TOKEN)) {
      await authStore.refreshToken();
      if (authStore.state is! Logged) {
        handler.next(err);
        return;
      }

      err.requestOptions.headers[REFRESHED_TOKEN] = '';

      final response = await _dio.request(
        err.requestOptions.path,
        cancelToken: err.requestOptions.cancelToken,
        data: err.requestOptions.data,
        onReceiveProgress: err.requestOptions.onReceiveProgress,
        onSendProgress: err.requestOptions.onSendProgress,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          contentType: err.requestOptions.contentType,
          headers: err.requestOptions.headers,
        ),
      );

      handler.resolve(response);
      return;
    } else if (err.requestOptions.headers.containsKey(REFRESHED_TOKEN)) {
      authStore.logout();
    }

    handler.next(err);
  }
}
