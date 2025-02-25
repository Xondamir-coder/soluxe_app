import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:transparent_image/transparent_image.dart';

final imagePath =
    'https://s3-alpha-sig.figma.com/img/0810/8c1c/87abcf5fe85ac215a85a8c7c4d2a690c?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=lGVb09jr1e1Vmos6tBL6D5j7e2WR8rLkXh-QN7oAkfDbIIkMoZwnyUXrb1DShpxKHCyxvh0cogOBPYyN3VURVCp3u-EA6-TiiHcKAfg1bfmW9DhX8bO~PTSBbnfVZwNezXjBTN2-BGNNtLEJeMkuMHBZdMAH6ruYHQdEU4Ok1lAi5DJTK4lsEWviIv6AhPzybGI64fhYDI2UGszm~RKMzJmZDe-N~i0~e5nbzEexsDHDfzGq6Axy87pHbdLaDRhQVYXXtqTFGO86EpZOZ0rEtrOPpU8awSW7yShrRfReVX34~K89svNKvSn5f7i0EvJKUV8~s-63hC0eVBNrJtlJnQ__';

class CategoriesImagePart extends StatefulWidget {
  const CategoriesImagePart({super.key});

  @override
  State<CategoriesImagePart> createState() => CategoriesImagePartState();
}

class CategoriesImagePartState extends State<CategoriesImagePart> {
  // List of images
  final List<String> images = [
    imagePath,
    'https://s3-alpha-sig.figma.com/img/280f/b0ec/e24c47e9e08fed0d79bb6fd6e4266431?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=QAR6X-goKOuvh9UvYI~mbktHmjrvrFN9-f~WV4zNxo1uM-lMtClwW5vE3HdMJ0CdYE8wfx61jhLHC8jBwdUuZLOxHjtv~0Egdv3~fcNRs3foHv0HemHs4A4OzFKiG2feirBmRHE73xzMMKyhqM2ZbHOVUJq7T4qjfar-li4zCvu4Sk2J5zv4CZjoa0K4n3JWyfb0LwpUbNVFTGQB3o~ydW~yKOdtM5BCCnQDJ5-BL90eQk63YK5zJNEUcJvRH6qOm87oyEa72chHJnj8qow8QJjFQozJW-AYsZ3tjt9-m0aeukxnpgf7Y40t~1SfO6MhepQpYAxIIhH2YFVAb6~r4A__',
    imagePath,
    imagePath,
    imagePath,
  ];
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
            itemCount: images.length,
            onPageChanged: (index) => _changeImage(index),
            itemBuilder: (context, index) {
              return FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: images[index],
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
                for (var i = 0; i < images.length; i++) ...[
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
