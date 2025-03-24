// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoriesPhotoTab extends StatelessWidget {
  final List<String> images;

  const CategoriesPhotoTab({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 164 / 154,
      ),
      itemCount: images.length,
      itemBuilder: (ctx, index) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: '${Constants.baseUrl}/${images[index]}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
