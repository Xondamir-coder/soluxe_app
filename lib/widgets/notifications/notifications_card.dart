import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/notification.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class NotificationsCard extends StatelessWidget {
  final NotificationModel notification;
  final bool isLastCard;

  const NotificationsCard({
    super.key,
    required this.notification,
    required this.isLastCard,
  });

  void _navigateToNotification(BuildContext context) {
    if (notification.isComment) {
      print('navigating to post of id: ${notification.post!.id}');
    }
  }

  Widget _buildProfileAvatar() {
    final hasProfileImg = notification.user.profileImgSrc.isNotEmpty;
    final shortenedName = notification.user.name.substring(0, 2).toUpperCase();
    final child = hasProfileImg
        ? Image.network(notification.user.profileImgSrc)
        : MyText(
            shortenedName,
            fontSize: 18,
            color: Colors.white,
          );

    return Container(
      width: 48,
      height: 48,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color.fromRGBO(136, 126, 249, 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Align(
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  Widget _buildMessage() {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.instrumentSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: notification.user.name,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('tapped username: ${notification.user.name}');
              },
            style: GoogleFonts.instrumentSans(
              color: AppColors.deepBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(text: " ${notification.message} "), // Ensure spacing
          TextSpan(
            text: notification.isComment
                ? notification.post!.title
                : notification.invitationLocation,
            style: GoogleFonts.instrumentSans(
              color: AppColors.deepBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDate() {
    return Row(
      spacing: 4,
      children: [
        SvgPicture.asset('assets/icons/clock.svg'),
        MyText(
          notification.formattedDate,
          color: AppColors.grey,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        spacing: 8,
        children: [
          ElevatedButton(
            onPressed: () {
              print('Accept button pressed');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentYellow,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: MyText('Accept', color: Colors.white),
          ),
          OutlinedButton(
            onPressed: () {
              print('Decline button pressed');
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(
                color: AppColors.accentYellow,
                width: 2,
              ),
              overlayColor: AppColors.accentYellow,
            ),
            child: MyText('Decline', color: AppColors.accentYellow),
          ),
        ],
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.white.withValues(alpha: .75),
      onTap: notification.isComment
          ? () => _navigateToNotification(context)
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          border: Border(
            bottom: isLastCard
                ? BorderSide.none
                : BorderSide(
                    color: AppColors.grey.withValues(alpha: 0.25),
                    width: 1,
                  ), // Bottom border
          ),
        ),
        child: Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns items properly
          children: [
            _buildProfileAvatar(), // Profile Avatar (Fixed Size)
            // Ensure the column takes remaining space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  _buildMessage(), // RichText with proper space
                  _buildDate(),
                  if (notification.type == NotificationType.invitation)
                    _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
