import 'package:flutter/material.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/faq/faq_topics.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqTopicsScreen extends StatelessWidget {
  const FaqTopicsScreen({super.key});

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
              onSearch: (query) => print(query),
            ),
            FaqTopics.grid(),
          ],
        ),
      ),
    );
  }
}
