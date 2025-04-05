import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final currencyProvider = StateNotifierProvider<CurrencyNotifier, double>((ref) {
  return CurrencyNotifier();
});

class CurrencyNotifier extends StateNotifier<double> {
  CurrencyNotifier() : super(0.0) {
    _fetchCurrency();
  }
  void _fetchCurrency() async {
    try {
      final url = Uri.parse('https://cbu.uz/ru/arkhiv-kursov-valyut/json/');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final obj = data.firstWhere((el) => el['Ccy'] == 'USD');
        state = double.tryParse(obj['Rate']) ?? 0;
      } else {
        throw Exception('Failed to fetch currency');
      }
    } catch (e) {
      rethrow;
    }
  }
}
