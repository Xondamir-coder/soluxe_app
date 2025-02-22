import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/category.dart';
import 'package:soluxe/screens/categories/categories_direction.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class GridCategoriesItem extends StatelessWidget {
  final Category category;

  const GridCategoriesItem({
    required this.category,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => CategoriesDirectionScreen(category: category),
            ),
          );
        },
        splashColor: category.color.withValues(alpha: .5),
        highlightColor: category.color.withValues(alpha: .25),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 68,
              height: 68,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                category.iconPath,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            MyText(
              category.name,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.deepBlue,
            ),
          ],
        ),
      ),
    );
  }
}
