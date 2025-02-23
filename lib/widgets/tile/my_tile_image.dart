import 'package:flutter/material.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class MyTileImage extends StatelessWidget {
  final String imgSrc;
  final String day;
  final String month;

  const MyTileImage({
    super.key,
    required this.imgSrc,
    this.day = '',
    this.month = '',
  });

  @override
  Widget build(BuildContext context) {
    if (day.isNotEmpty && month.isNotEmpty) {
      return Container(
        width: 90,
        height: 90,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: FadeInImage.memoryNetwork(
                image: imgSrc,
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText.deepBlue(day, height: 1),
                    MyText.grey(month, fontSize: 10, height: 1),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: FadeInImage.memoryNetwork(
        image: imgSrc,
        placeholder: kTransparentImage,
        width: 72,
        height: 72,
        fit: BoxFit.cover,
      ),
    );
  }
}
