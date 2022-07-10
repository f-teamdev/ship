import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../constants.dart';
import 'local_data_service.dart';

abstract class IHasuraService {
  Future<dynamic> query(String document, {Map<String, dynamic>? variables, bool withAuth = true});
  Future<dynamic> mutation(String document, {Map<String, dynamic>? variables, bool withAuth = true});
}

late final _globalClient = HasuraConnect(HASURA_URL, interceptors: [
  AuthInterceptor(),
]);

class HasuraService implements IHasuraService {
  late final HasuraConnect _connect;

  HasuraService([HasuraConnect? connect]) {
    _connect = connect ?? _globalClient;
  }

  @override
  Future<dynamic> mutation(String document, {Map<String, dynamic>? variables, bool withAuth = true}) {
    return _connect.mutation(document, variables: variables);
  }

  @override
  Future<dynamic> query(String document, {Map<String, dynamic>? variables, bool withAuth = true}) {
    return _connect.query(document, variables: variables);
  }
}

class AuthInterceptor extends InterceptorBase {
  @override
  Future? onRequest(Request request) async {
    if (request.headers.containsKey('no-auth')) {
      return request;
    }
    final local = Modular.get<LocalData>();
    final token = await local.get(tokenKey);
    if (token.isEmpty) {
      return TokenError('Token vazio', request);
    }

    request.headers['Authorization'] = 'Bearer $token';
    return request;
  }

  @override
  Future? onError(HasuraError error) async {
    if (error is TokenError) {
      Modular.to.navigate('/auth/');
    }

    return error;
  }
}

class TokenError extends HasuraError {
  TokenError(String message, Request request) : super(message, request: request);
}
