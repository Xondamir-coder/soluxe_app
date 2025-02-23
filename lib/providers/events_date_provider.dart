import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);
