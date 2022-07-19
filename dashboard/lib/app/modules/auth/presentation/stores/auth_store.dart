import 'package:flutter_triple/flutter_triple.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../shared/adapters/either_adapter.dart';
import '../../domain/entities/tokenization.dart';
import '../../domain/exceptions/exceptions.dart';
import '../../domain/params/login_credentials.dart';
import '../../domain/usecases/check_token.dart';
import '../../domain/usecases/get_tokenization.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/refresh_token.dart';
import '../../domain/usecases/save_tokenization.dart';
import '../states/auth_state.dart';

class AuthStore extends StreamStore<AuthException, AuthState> {
  final RefreshToken _refreshTokenUsecase;
  final Login _loginUsecase;
  final SaveTokenization _saveTokenUsecase;
  final GetTokenization _getTokenUsecase;
  final Logout _logoutUsecase;
  final CheckToken _checkToken;

  AuthStore(
    this._refreshTokenUsecase,
    this._loginUsecase,
    this._saveTokenUsecase,
    this._getTokenUsecase,
    this._logoutUsecase,
    this._checkToken,
  ) : super(AuthInProgress());

  Future<void> checkAuth() async {
    final result = await _getTokenUsecase //
        .call()
        .flatMap(_refreshTokenUsecase.call)
        .flatMap(_checkToken.call)
        .flatMap(saveToken)
        .map(Logged.new)
        .mapLeft(_offlineStateFilter)
        .run();
    final newState = result.fold(id, id);
    update(newState);
  }

  AuthState _offlineStateFilter(AuthException exception) {
    if (exception.networkException?.statusCode == 404) {
      return OfflineAuth();
    }

    return Unlogged();
  }

  Future<void> logout() async {
    final task = _logoutUsecase().map((r) => Unlogged());
    await executeEither(() => CustomEitherAdapter.adapter(task));
    setLoading(false);
  }

  Future<void> login(LoginCredentials credentials) async {
    final state = this.state;
    if (state is Logged) {
      return;
    } else {
      await executeEither(() {
        final either = _loginUsecase(credentials) //
            .flatMap(saveToken)
            .map(Logged.new);
        final adapter = CustomEitherAdapter.adapter(either);
        return adapter;
      });
      setLoading(false);
    }
  }

  Future<void> refreshToken() async {
    final state = this.state;
    if (state is! Logged) {
      return;
    } else {
      final token = state.tokenization;
      await executeEither(
        () {
          final either = _refreshTokenUsecase(token) //
              .flatMap(saveToken)
              .map(Logged.new);
          final adapter = CustomEitherAdapter.adapter(either);
          return adapter;
        },
      );
      setLoading(false);
    }
  }

  TaskEither<AuthException, Tokenization> saveToken(Tokenization tokenization) {
    return _saveTokenUsecase(tokenization).map((r) => tokenization);
  }
}
