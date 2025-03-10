import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';

class ProviderHelper {
  // Google Sign In configuration
  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // Google Sign In method
  static Future<void> signInWithGoogle({bool isRegister = true}) async {
    try {
      // Google sign
      final account = await googleSignIn.signIn();

      // Server sign
      final endpoint = isRegister ? 'register' : 'login';
      final res = await http.post(
        Uri.parse('${Constants.baseUrl}/$endpoint'),
        body: json.encode({
          'email': account?.email,
          if (isRegister) 'full_name': account?.displayName,
          'auth_provider': 'google',
        }),
      );
      final Map<String, dynamic> resBody = json.decode(res.body);

      if (account == null) return;

      // Update local state
      await LocalStorageHelper.saveUserData(
        token: resBody['token'],
        email: resBody['user']['email'],
        fullName: resBody['user']['full_name'],
      );
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  // Google Sign Out method
  static Future<void> signOutWithGoogle() async {
    try {
      // Sign out
      await googleSignIn.signOut();

      // Update local state
      await LocalStorageHelper.deleteUserData();
    } catch (e) {
      print('Error signing out with Google: $e');
    }
  }
}
