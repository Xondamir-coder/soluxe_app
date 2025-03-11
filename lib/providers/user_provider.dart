import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/models/user_summary.dart';

final userProvider = StateProvider<UserSummary>(
  (ref) => UserSummary(),
);
