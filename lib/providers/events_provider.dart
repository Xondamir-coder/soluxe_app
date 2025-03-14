import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/models/event/event.dart';
import 'package:soluxe/providers/account_provider.dart';

class EventsNotifier extends StateNotifier<List<Event>> {
  final Ref ref;

  EventsNotifier(this.ref) : super(const []);

  void fetchEvents() async {
    try {
      final events = await FetchHelper.fetch(
        url: '${Constants.apiUrl}/events',
        token: ref.read(accountProvider).token,
      );
      final data = events['data'];
      for (final event in data) {
        state = [Event.fromMap(event)];
      }
      print(state);
    } catch (e) {
      rethrow;
    }
  }
}

final eventsProvider = StateNotifierProvider<EventsNotifier, List<Event>>(
  (ref) => EventsNotifier(ref),
);

final eventsDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);
