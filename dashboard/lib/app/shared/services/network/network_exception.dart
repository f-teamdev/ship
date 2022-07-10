enum NetworkExceptionType {
  /// It occurs when url is opened timeout.
  connectTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// When the server response, but with a incorrect status, such as 404, 503...
  response,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Default error type, Some other Error. In this case, you can
  /// use the NetworkExceptionType.error if it is not null.
  other,
}

class NetworkException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final int statusCode;
  final NetworkExceptionType type;
  final dynamic data;

  NetworkException(
    this.message,
    this.data, {
    this.stackTrace,
    required this.statusCode,
    this.type = NetworkExceptionType.other,
  });
}
