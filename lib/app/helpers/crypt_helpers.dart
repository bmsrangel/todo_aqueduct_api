import 'dart:convert';
import 'package:crypto/crypto.dart';

class CryptHelpers {
  static String generateSHA256Hash(String password) {
    final List<int> bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
