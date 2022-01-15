import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenRepository {
  static const storage = FlutterSecureStorage();

  static String? _accessToken;

  static Future<String?> getAccessToken() async {
    _accessToken ??= await storage.read(key: 'accessToken');
    return _accessToken;
  }

  static Future<void> setAccessToken(String? value) async {
    _accessToken = value;
    await storage.write(key: 'accessToken', value: value);
  }

  static Future<String?> getRefreshToken() async =>
      await storage.read(key: 'refreshToken');

  static Future<void> setRefreshToken(String? value) async =>
      await storage.write(key: 'refreshToken', value: value);

  static Future<String?> getCurrentUserId() async =>
      await storage.read(key: 'currentUserId');

  static Future<void> setCurrentUserId(String? value) async =>
      await storage.write(key: 'currentUserId', value: value);
}
