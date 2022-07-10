import 'package:flutter_triple/flutter_triple.dart';

import '../../domain/exceptions/exceptions.dart';
import '../states/auth_state.dart';

class AuthStore extends StreamStore<AuthException, AuthState> {
  AuthStore() : super(AuthInProgress());

  Future<void> checkAuth() async {}

  Future<void> refreshToken() async {}
}
