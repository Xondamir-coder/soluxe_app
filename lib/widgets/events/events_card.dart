import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/event.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class EventsCard extends StatelessWidget {
  final Event event;

  const EventsCard({super.key, required this.event});

  Widget _buildImageContainer() {
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
            child: Image.network(
              event.imgSrc,
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
                children: [
                  Text(
                    event.day,
                    style: GoogleFonts.instrumentSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepBlue,
                    ),
                  ),
                  Text(
                    event.month,
                    style: GoogleFonts.instrumentSans(
                      fontSize: 10,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      spacing: 4,
      children: [
        SvgPicture.asset('assets/icons/pin.svg'),
        MyText(
          event.city,
          fontSize: 14,
          color: AppColors.grey,
        ),
      ],
    );
  }

  Widget _buildDistance() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color.fromRGBO(249, 245, 235, 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: MyText(
        '${event.distance} Km',
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppColors.accentYellow,
      ),
    );
  }

  Widget _buildTitle() {
    return MyText(
      event.title,
      fontSize: 16,
      color: AppColors.deepBlue,
      fontWeight: FontWeight.w700,
    );
  }

  Widget _buildBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLocation(),
        _buildDistance(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        spacing: 10,
        children: [
          _buildImageContainer(),
          Expanded(
            child: Column(
              spacing: 10,
              children: [
                _buildTitle(),
                _buildBottom(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
