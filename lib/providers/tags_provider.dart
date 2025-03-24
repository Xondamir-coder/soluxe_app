import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/place/tag.dart';

class EventsNotifier extends StateNotifier<List<Tag>> {
  EventsNotifier() : super(const []) {
    fetchTags();
  }

  void fetchTags() async {
    try {
      final token = (await LocalStorageHelper.getAccountData()).token;
      final body = await FetchHelper.fetch(
        url: 'tags',
        token: token,
      );
      for (final data in body['data']) {
        state = [...state, Tag.fromMap(data)];
      }
    } catch (e) {
      rethrow;
    }
  }
}

final tagsProvider = StateNotifierProvider<EventsNotifier, List<Tag>>(
  (ref) => EventsNotifier(),
);
