import 'package:flutter/material.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/faq/faq_category.dart';
import 'package:soluxe/models/faq/faq_question.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/faq/faq_accordions.dart';
import 'package:soluxe/widgets/my_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqQuestionsScreen extends StatefulWidget {
  final FaqCategory faqCategory;

  const FaqQuestionsScreen({
    required this.faqCategory,
    super.key,
  });

  @override
  State<FaqQuestionsScreen> createState() => _FaqQuestionsScreenState();
}

class _FaqQuestionsScreenState extends State<FaqQuestionsScreen> {
  final _questionsNotifier = ValueNotifier<List<FaqQuestion>>([]);

  void _fetchQuestions({String? query}) async {
    final body = await FetchHelper.fetch(
        url: 'faqs',
        token: (await LocalStorageHelper.getAccountData()).token,
        queryParams: {
          'category_id': widget.faqCategory.id.toString(),
          if (query != null) 'search': query,
        });
    final arr = body['data'] as List;
    _questionsNotifier.value =
        arr.map((el) => FaqQuestion.fromMap(el)).toList();
  }

  @override
  void dispose() {
    _questionsNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!.localeName;

    return Scaffold(
      appBar: DefaultAppbar(
        title: (locale == 'en'
                ? widget.faqCategory.titleEn
                : widget.faqCategory.titleZh) ??
            'Unknown',
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            MySearchBar(
              label: AppLocalizations.of(context)!.search,
              onSearch: (query) {
                _fetchQuestions(query: query);
              },
            ),
            ValueListenableBuilder(
              valueListenable: _questionsNotifier,
              builder: (ctx, val, child) => val.isNotEmpty
                  ? Expanded(
                      child: FaqAccordions(questions: val),
                    )
                  : CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
  }
}
