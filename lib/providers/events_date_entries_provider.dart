import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/date_entry.dart';
import 'package:soluxe/providers/events_provider.dart';
import 'package:http/http.dart' as http;

class EventsDateEntriesNotifier extends StateNotifier<List<DateEntry>> {
  final Ref ref;

  EventsDateEntriesNotifier({
    required this.ref,
  }) : super(const []) {
    _initialize();
  }

  void _initialize() async {
    state = [];
    final date = ref.read(eventsDateProvider);
    final queryParams = {
      'month': (date.month - 1).toString(),
      'year': (date.year).toString(),
    };
    final token = (await LocalStorageHelper.getAccountData()).token;
    final res = await http.get(
      Uri.parse('${Constants.apiUrl}/events-in-month')
          .replace(queryParameters: queryParams),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final body = await json.decode(res.body);
    for (var i = 0; i < body.length; i++) {
      final Map<String, dynamic> data = body[i];
      state.add(DateEntry.fromMap(data));
    }
  }
}

final eventsDateEntriesProvider =
    StateNotifierProvider<EventsDateEntriesNotifier, List<DateEntry>>(
  (ref) => EventsDateEntriesNotifier(ref: ref),
);
