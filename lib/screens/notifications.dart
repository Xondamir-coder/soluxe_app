import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/data/notifications.dart';
import 'package:soluxe/widgets/notifications/notifications_appbar.dart';
import 'package:soluxe/widgets/notifications/notifications_card.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: NotificationsAppBar(),
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) => NotificationsCard(
                notification: notifications[index],
                isLastCard: index == notifications.length - 1,
              ),
            )
          : Container(
              padding: EdgeInsets.only(top: 80),
              width: double.infinity,
              child: Column(
                spacing: 30,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/vectors/not-found.svg'),
                  Column(
                    spacing: 8,
                    children: [
                      MyTitle(
                        'Not found',
                        color: AppColors.accentYellow,
                      ),
                      MyText(
                        'Morbi magnis sollicitudin ipsum \nfacilisi vestibulum',
                        color: AppColors.grey,
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
