import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class CategoryTabs extends StatelessWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;
  final String selectedCategory;
  final String iconPath;
  final Color bgColor;

  const CategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onCategorySelected,
    this.iconPath = '',
    this.bgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45, // Adjust height as needed
      child: ListView.separated(
        separatorBuilder: (ctx, index) => const SizedBox(width: 10),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final String category = categories[index];
          bool isSelected = category == selectedCategory;
          final backColor = isSelected ? AppColors.accentYellow : bgColor;
          final textColor = isSelected ? Colors.white : AppColors.deepBlue;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                decoration: BoxDecoration(
                  color: backColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(107, 114, 128, 0.04),
                      blurRadius: 10,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  spacing: 6,
                  children: [
                    if (isSelected)
                      SvgPicture.asset(
                        'assets/icons/flash.svg',
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    if (!isSelected && iconPath.isNotEmpty)
                      SvgPicture.asset(
                        iconPath,
                        colorFilter: ColorFilter.mode(
                          AppColors.darkBrown,
                          BlendMode.srcIn,
                        ),
                        width: 18,
                        height: 18,
                      ),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: GoogleFonts.instrumentSans(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: textColor,
                      ),
                      child: Text(category),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
