import 'package:flutter/material.dart';
import 'package:soluxe/models/hotel/hotel_comment.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:transparent_image/transparent_image.dart';

class HotelCommentsItem extends StatelessWidget {
  final HotelComment comment;

  const HotelCommentsItem({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.grey(comment.text, fontSize: 12),
          Row(
            spacing: 6,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: comment.imgSrc,
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  MyText(comment.name, fontSize: 11),
                  MyText.grey(comment.formattedDate, fontSize: 11),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
