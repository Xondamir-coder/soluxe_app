import 'package:flutter/material.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/faq/faq_category.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/async_widget.dart';
import 'package:soluxe/widgets/faq/faq_category_item.dart';

class FaqCategories extends StatelessWidget {
  final bool isGrid;
  final String? query;

  const FaqCategories({super.key, this.query}) : isGrid = false;
  const FaqCategories.grid({super.key, this.query}) : isGrid = true;

  Future<List<FaqCategory>> _fetchFaqCategories() async {
    final body = await FetchHelper.fetch(
      url: 'faqs-categories',
      token: (await LocalStorageHelper.getAccountData()).token,
      queryParams: query != null ? {'search': query} : null,
    );
    final arr = body['data'] as List;
    return arr.map((el) => FaqCategory.fromMap(el)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!isGrid) {
      return AsyncWidget(
        future: _fetchFaqCategories(),
        builder: (ctx, val) => SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) => SizedBox(
              width: 155,
              child: FaqCategoryItem(
                faqCategory: val[index],
              ),
            ),
            separatorBuilder: (ctx, index) => const SizedBox(width: 10),
            itemCount: val.length,
          ),
        ),
      );
    } else {
      return AsyncWidget(
        future: _fetchFaqCategories(),
        builder: (ctx, val) => Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 163 / 131,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (ctx, index) => ScaleUpWidget(
              delay: index * 75 + 250,
              child: FaqCategoryItem(
                faqCategory: val[index],
              ),
            ),
            itemCount: val.length,
          ),
        ),
      );
    }
  }
}
