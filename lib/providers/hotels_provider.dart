import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:http/http.dart' as http;

class EventsNotifier extends StateNotifier<List<Place>> {
  EventsNotifier() : super(const []) {
    fetchHotels();
  }

  void fetchHotels() async {
    try {
      final token = (await LocalStorageHelper.getAccountData()).token;
      final body = await FetchHelper.fetch(
        url: 'places',
        token: token,
        queryParams: {'category': 'Hotels'},
      );
      for (final data in body['data']) {
        state = [...state, Place.fromMap(data)];
      }
    } catch (e) {
      rethrow;
    }
  }

  void cleanHotels() {
    state = [];
  }

  void fetchFavoriteHotels() async {
    try {
      final token = (await LocalStorageHelper.getAccountData()).token;
      final res = await http.get(
        Uri.parse('${Constants.apiUrl}/places').replace(
          queryParameters: {'favorite': 'true', 'category': 'Hotels'},
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final List body = json.decode(res.body);

      for (final data in body) {
        state = [...state, Place.fromMap(data)];
      }
    } catch (e) {
      rethrow;
    }
  }
}

final hotelsProvider = StateNotifierProvider<EventsNotifier, List<Place>>(
  (ref) => EventsNotifier(),
);
