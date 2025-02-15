import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class CategoryTabs extends StatefulWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  var _selectedCategoryName = '';

  @override
  void initState() {
    _selectedCategoryName = widget.categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final String category = widget.categories[index];
          bool isSelected = category == _selectedCategoryName;

          return GestureDetector(
            onTap: () {
              // Change UI
              setState(() {
                _selectedCategoryName = category;
              });

              // Send to parent
              widget.onCategorySelected(_selectedCategoryName);
            },
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accentYellow : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(107, 114, 128, 0.04),
                      blurRadius: 10,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    if (isSelected) SvgPicture.asset('assets/icons/flash.svg'),
                    if (isSelected) const SizedBox(width: 6),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: GoogleFonts.instrumentSans(
                        fontSize: 16,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.deepBlue,
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
