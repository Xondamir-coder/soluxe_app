import 'package:flutter/material.dart';
import 'package:soluxe/widgets/categories/categories_content.dart';
import 'package:soluxe/widgets/categories/categories_image_part.dart';

class CategoriesBottomSheet extends StatelessWidget {
  const CategoriesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CategoriesImagePart(),
        const CategoriesContent(),
      ],
    );
  }
}
