import 'package:flutter/material.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/l10n/app_localizations.dart';
import 'package:soluxe/widgets/async_widget.dart';
import 'package:soluxe/models/place/review.dart';
import 'package:soluxe/widgets/hotel/hotel_comment.dart';

class ReviewsScreen extends StatelessWidget {
  final int placeId;
  const ReviewsScreen({super.key, required this.placeId});

  Future<List<Review>> fetchData() async {
    final body = await FetchHelper.fetch(
      url: 'reviews',
      queryParams: {'place_id': placeId.toString()},
    );
    final list = body['data'] as List;
    return list.isNotEmpty
        ? list.map((item) => Review.fromMap(item)).toList()
        : <Review>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        title: AppLocalizations.of(context)!.reviews,
      ),
      body: AsyncWidget<List<Review>>(
        future: fetchData(),
        builder: (context, data) {
          return ListView.separated(
            padding: EdgeInsets.all(16),
            itemBuilder: (ctx, index) => ScaleUpWidget.fade(
              beginScale: 0.85,
              delay: index * 100,
              child: HotelComment(
                comment: data[index],
                credentialsSize: 15,
                textSize: 16,
                imageSize: 50,
                dividerSpacing: 10,
                imageCredentialsSpacing: 12,
                rightMargin: 0,
                padding: 16,
              ),
            ),
            separatorBuilder: (ctx, index) => const SizedBox(height: 10),
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
