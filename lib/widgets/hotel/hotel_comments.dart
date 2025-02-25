import 'package:flutter/material.dart';
import 'package:soluxe/models/hotel/hotel_comment.dart';
import 'package:soluxe/widgets/hotel/hotel_comments_item.dart';

class HotelComments extends StatelessWidget {
  final List<HotelComment> comments;

  const HotelComments({required this.comments, super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) => HotelCommentsItem(
        comment: comments[index],
      ),
    );
  }
}
