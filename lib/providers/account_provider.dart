import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/models/account.dart';

final accountProvider = StateProvider<Account>(
  (ref) => Account(),
);
