import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/date_entry.dart';
import 'package:soluxe/widgets/date_pickers/expanded_date_picker.dart';
import 'package:http/http.dart' as http;

class FilterSheetDatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<String> onDateChange;

  const FilterSheetDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  @override
  State<FilterSheetDatePicker> createState() => _FilterSheetDatePickerState();
}

class _FilterSheetDatePickerState extends State<FilterSheetDatePicker> {
  final List<DateEntry> _entries = [];
  bool _isLoading = true;

  void _fetchEntries() async {
    final queryParams = {
      'month': (widget.selectedDate.month - 1).toString(),
      'year': (widget.selectedDate.year).toString(),
    };
    final token = (await LocalStorageHelper.getAccountData()).token;
    final res = await http.get(
      Uri.parse('${Constants.apiUrl}/places-in-month')
          .replace(queryParameters: queryParams),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final body = (await json.decode(res.body)) as List;
    for (var i = 0; i < body.length; i++) {
      final Map<String, dynamic> data = body[i];
      _entries.add(DateEntry.fromMap(data));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ExpandedDatePicker(
            date: widget.selectedDate,
            dateEntries: _entries,
            darkBlueBgColor: true,
            onDateChange: widget.onDateChange,
          );
  }
}
