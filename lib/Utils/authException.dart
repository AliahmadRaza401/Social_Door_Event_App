class AuthException implements Exception {
  final message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
