class DatabaseErrorException implements Exception {
  DatabaseErrorException(this.message);
  final String message;
}
