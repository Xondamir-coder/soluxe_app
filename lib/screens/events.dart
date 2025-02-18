import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/data/events.dart';
import 'package:soluxe/widgets/buttons/circular_back_button.dart';
import 'package:soluxe/widgets/events/events_card.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/title_appbar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.creamWhite,
      title: const TitleAppbar('Events'),
      centerTitle: true,
      leading: const CircularBackButton(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/icons/filter.svg'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _buildAppBar(context),
      ),
      body: Column(
        spacing: 16,
        children: [
          Text('date'),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) => EventsCard(
                event: events[index],
              ),
              itemCount: events.length,
            ),
          ),
        ],
      ),
    );
  }
}
