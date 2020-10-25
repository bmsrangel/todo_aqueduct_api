class DuplicatedKeyException implements Exception {
  DuplicatedKeyException(this.message);
  final String message;
}
