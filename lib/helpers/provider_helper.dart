import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/user.dart';
import 'package:soluxe/providers/account_provider.dart';

class ProviderHelper {
  // Google Sign In configuration
  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // Google Sign In method
  static Future<void> signInWithGoogle({
    bool isRegister = true,
    required WidgetRef ref,
  }) async {
    try {
      // Google sign
      final account = await googleSignIn.signIn();

      // Server sign
      final endpoint = isRegister ? 'register' : 'login';
      final body = await FetchHelper.fetch(
        url: endpoint,
        method: HttpMethod.post,
        reqBody: {
          'email': account?.email,
          if (isRegister) 'full_name': account?.displayName,
          'auth_provider': 'google',
        },
      );

      if (account == null) return;

      // Update state/storage
      final accountNotifier = ref.read(accountProvider.notifier);
      accountNotifier.updateAccount(
        token: body['token'] as String,
        user: User.fromMap(body['user'] as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Google Sign Out method
  static Future<void> signOutWithGoogle() async {
    try {
      // Sign out
      await googleSignIn.signOut();

      // Update local state
      await LocalStorageHelper.deleteAccountData();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signInWithApple({
    bool isRegister = true,
    required WidgetRef ref,
  }) async {
    try {
      // Perform Apple sign-in
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final endpoint = isRegister ? 'register' : 'login';

      // Send request to server
      final body = await FetchHelper.fetch(
        url: endpoint,
        method: HttpMethod.post,
        reqBody: {
          'email':
              credential.email ?? '', // Some users might not share their email
          if (isRegister) 'full_name': credential.givenName ?? '',
          'auth_provider': 'apple',
        },
      );

      // Update state/storage
      final accountNotifier = ref.read(accountProvider.notifier);
      accountNotifier.updateAccount(
        token: body['token'] as String,
        user: User.fromMap(body['user'] as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOutWithApple() async {
    try {
      await LocalStorageHelper.deleteAccountData();
    } catch (e) {
      rethrow;
    }
  }
}
