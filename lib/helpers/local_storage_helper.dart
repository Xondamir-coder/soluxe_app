import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soluxe/models/account.dart';
import 'package:soluxe/models/user.dart';

class LocalStorageHelper {
  // Create an instance of FlutterSecureStorage
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Save user token and details
  static Future<void> saveAccountData({
    required String token,
    required User user,
  }) async {
    await _secureStorage.write(key: 'token', value: token);
    await _secureStorage.write(key: 'user', value: user.toJson());
  }

  // Retrieve user data
  static Future<Account> getAccountData() async {
    final token = await _secureStorage.read(key: 'token');
    final user = await _secureStorage.read(key: 'user');
    return Account(
      token: token!,
      user: User.fromJson(user!),
    );
  }

  // Delete user data (e.g., during sign out)
  static Future<void> deleteAccountData() async {
    await _secureStorage.delete(key: 'token');
    await _secureStorage.delete(key: 'user');
  }
}
