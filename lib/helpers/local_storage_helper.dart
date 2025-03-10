import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soluxe/models/user_summary.dart';

class LocalStorageHelper {
  // Create an instance of FlutterSecureStorage
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Save user token and details
  static Future<void> saveUserData({
    required String token,
    required String email,
    required String fullName,
  }) async {
    await _secureStorage.write(key: 'token', value: token);
    await _secureStorage.write(key: 'email', value: email);
    await _secureStorage.write(key: 'fullName', value: fullName);
  }

  // Retrieve user data
  static Future<UserSummary> getUserData() async {
    final token = await _secureStorage.read(key: 'token');
    final email = await _secureStorage.read(key: 'email');
    final fullName = await _secureStorage.read(key: 'fullName');
    return UserSummary(
      id: token!,
      email: email!,
      name: fullName!,
    );
  }

  // Delete user data (e.g., during sign out)
  static Future<void> deleteUserData() async {
    await _secureStorage.delete(key: 'token');
    await _secureStorage.delete(key: 'email');
    await _secureStorage.delete(key: 'fullName');
  }
}
