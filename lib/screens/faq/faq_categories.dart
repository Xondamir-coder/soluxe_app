import 'package:flutter/material.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/faq/faq_categories.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqCategoriesScreen extends StatefulWidget {
  const FaqCategoriesScreen({super.key});

  @override
  State<FaqCategoriesScreen> createState() => _FaqCategoriesScreenState();
}

class _FaqCategoriesScreenState extends State<FaqCategoriesScreen> {
  final _queryNotifier = ValueNotifier('');

  @override
  void dispose() {
    _queryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(title: AppLocalizations.of(context)!.browseByTopic),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            MySearchBar(
              label: AppLocalizations.of(context)!.search,
              onSearch: (query) {
                _queryNotifier.value = query;
              },
            ),
            ValueListenableBuilder(
              valueListenable: _queryNotifier,
              builder: (ctx, val, child) => FaqCategories.grid(query: val),
            ),
          ],
        ),
      ),
    );
  }
}
