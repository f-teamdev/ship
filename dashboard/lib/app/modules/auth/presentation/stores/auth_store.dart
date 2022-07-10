import 'package:flutter_triple/flutter_triple.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ship_dashboard/app/modules/auth/domain/entities/tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/params/login_credentials.dart';
import 'package:ship_dashboard/app/modules/auth/domain/usecases/get_tokenization.dart';
import 'package:ship_dashboard/app/modules/auth/domain/usecases/refresh_token.dart';
import 'package:ship_dashboard/app/modules/auth/domain/usecases/save_tokenization.dart';
import 'package:ship_dashboard/app/shared/adapters/either_adapter.dart';

import '../../domain/exceptions/exceptions.dart';
import '../../domain/usecases/login.dart';
import '../states/auth_state.dart';

class AuthStore extends StreamStore<AuthException, AuthState> {
  final RefreshToken _refreshTokenUsecase;
  final Login _loginUsecase;
  final SaveTokenization _saveTokenUsecase;
  final GetTokenization _getTokenUsecase;

  AuthStore(
    this._refreshTokenUsecase,
    this._loginUsecase,
    this._saveTokenUsecase,
    this._getTokenUsecase,
  ) : super(AuthInProgress());

  Future<void> checkAuth() async {
    await executeEither(() => CustomEitherAdapter.adapter(_getTokenUsecase().map(Logged.new)));
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
      final token = state.tokenization.refreshToken;
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
