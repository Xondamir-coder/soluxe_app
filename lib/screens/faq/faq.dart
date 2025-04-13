import 'package:flutter/material.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/faq/faq_question.dart';
import 'package:soluxe/screens/faq/faq_categories.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/animations/slide_in_widget.dart';
import 'package:soluxe/widgets/faq/faq_accordions.dart';
import 'package:soluxe/widgets/faq/faq_categories.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:soluxe/widgets/section_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final questionsNotifier = ValueNotifier<List<FaqQuestion>>([]);

  void _fetchQuestions({String? query}) async {
    final body = await FetchHelper.fetch(
      url: 'faqs',
      token: (await LocalStorageHelper.getAccountData()).token,
      queryParams: query != null
          ? {
              'search': query,
            }
          : null,
    );
    final arr = body['data'] as List;
    questionsNotifier.value = arr.map((el) => FaqQuestion.fromMap(el)).toList();
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  @override
  void dispose() {
    questionsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(title: AppLocalizations.of(context)!.faq),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            MySearchBar(
              label: AppLocalizations.of(context)!.search,
              onSearch: (query) {
                _fetchQuestions(query: query);
              },
            ),
            SectionHeader(
              title: AppLocalizations.of(context)!.browseByTopic,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const FaqCategoriesScreen(),
                ),
              ),
            ),
            SlideInWidget.fade(
              begin: Offset(0, 0.25),
              child: const FaqCategories(),
            ),
            ValueListenableBuilder(
              valueListenable: questionsNotifier,
              builder: (ctx, val, child) => Expanded(
                child: FaqAccordions(questions: val),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
