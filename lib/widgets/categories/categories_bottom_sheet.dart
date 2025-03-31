import 'package:flutter/material.dart';
import 'package:soluxe/models/place/place.dart';
import 'package:soluxe/widgets/categories/categories_content.dart';
import 'package:soluxe/widgets/categories/categories_image_part.dart';

class CategoriesBottomSheet extends StatelessWidget {
  final Place place;

  const CategoriesBottomSheet({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CategoriesImagePart(
              images: place.images!.length > 4
                  ? place.images!.sublist(0, 4)
                  : place.images!),
          CategoriesContent(place: place),
        ],
      ),
    );
  }
}
