import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoriesImagePart extends StatefulWidget {
  final List<String> images;

  const CategoriesImagePart({super.key, required this.images});

  @override
  State<CategoriesImagePart> createState() => CategoriesImagePartState();
}

class CategoriesImagePartState extends State<CategoriesImagePart> {
  int _currentIndex = 0;
  final _pageController = PageController(initialPage: 0);

  void _changeImage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make sure it takes full width
      height: 180,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) => _changeImage(index),
            itemBuilder: (context, index) {
              return FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: '${Constants.baseUrl}/${widget.images[index]}',
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            bottom: 56, // same as 20 + 36
            left: 0,
            right: 0,
            child: Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.images.length; i++) ...[
                  Material(
                    color:
                        _currentIndex == i ? Colors.white : AppColors.shadyGrey,
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => _pageController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      ),
                      child: SizedBox(
                        width: 34.4,
                        height: 4,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
