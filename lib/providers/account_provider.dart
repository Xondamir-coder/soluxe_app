import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/account.dart';
import 'package:soluxe/models/user.dart';

class AccountNotifier extends StateNotifier<Account> {
  AccountNotifier() : super(Account()) {
    _initializeAccount();
  }

  Future<void> _initializeAccount() async {
    final account = await LocalStorageHelper.getAccountData();
    state = account;
  }

  void updateAccount({String? token, User? user}) async {
    state = Account(token: token, user: user);
    await LocalStorageHelper.saveAccountData(
      token: token ?? '',
      user: user ?? User(),
    );
  }
}

final accountProvider = StateNotifierProvider<AccountNotifier, Account>(
  (ref) => AccountNotifier(),
);
