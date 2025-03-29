// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/widgets/tile/my_tile.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class CategoriesItems extends StatelessWidget {
  final String? subCategory;
  final String category;
  final Map<String, dynamic> params;

  const CategoriesItems({
    super.key,
    required this.params,
    required this.category,
    this.subCategory,
  });

  Future<List<Place>> _fetchPlaces() async {
    final token = (await LocalStorageHelper.getAccountData()).token;
    final List<Place> arr = [];

    try {
      final newParams = {
        ...params,
        'category': category,
        if (subCategory != null && subCategory!.isNotEmpty)
          'sub_category': subCategory,
      };
      final body = await FetchHelper.fetch(
        url: 'places',
        token: token,
        queryParams: newParams,
      );

      if ((body['data'] as List).isEmpty) throw 'No places found';

      for (final item in body['data']) {
        arr.add(Place.fromMap(item));
      }
      return arr;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: _fetchPlaces(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Expanded(
            child: ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) => MyTile(
                place: snapshot.data![index],
              ),
            ),
          );
        } else {
          return Center(
            child: MyText.warmBrown(
              snapshot.error.toString(),
              fontSize: 18,
            ),
          );
        }
      },
    );
  }
}
