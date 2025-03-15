import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/event/event.dart';

class EventsNotifier extends StateNotifier<List<Event>> {
  EventsNotifier() : super(const []) {
    fetchEvents();
  }

  void fetchEvents() async {
    try {
      final token = (await LocalStorageHelper.getAccountData()).token;
      final body = await FetchHelper.fetch(
        url: 'events',
        token: token,
      );
      for (final data in body['data']) {
        state = [...state, Event.fromMap(data)];
      }
    } catch (e) {
      rethrow;
    }
  }
}

final eventsProvider = StateNotifierProvider<EventsNotifier, List<Event>>(
  (ref) => EventsNotifier(),
);

final eventsDateProvider = StateProvider<DateTime>(
  (ref) => DateTime.now(),
);
