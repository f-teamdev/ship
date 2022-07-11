abstract class CustomException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const CustomException(this.message, [this.stackTrace]);

  @override
  String toString() {
    return '$runtimeType: $message\n${stackTrace != null ? stackTrace.toString() : ''}';
  }
}
