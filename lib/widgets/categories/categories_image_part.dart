import 'package:flutter/material.dart';

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
    imagePath,
    imagePath,
    imagePath,
  ];
  int currentIndex = 0;

  void changeImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      images[currentIndex],
      fit: BoxFit.cover,
      height: 180,
    );
  }
}
