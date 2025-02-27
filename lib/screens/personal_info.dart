import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/data/user.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/settings/settings_form.dart';
import 'package:transparent_image/transparent_image.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  Widget _buildProfile(bool isDark) {
    return Container(
      width: 100,
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.adaptiveDarkBlueOrWhite(isDark),
        border: Border.all(
          color: AppColors.adaptiveDarkBlueOrWhite(isDark),
          width: 6,
        ),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: FadeInImage.memoryNetwork(
                image: appUser.profileImgSrc,
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: Container(
                height: 30,
                padding: EdgeInsets.all(6),
                color: AppColors.deepBlue.withValues(alpha: .1),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: SvgPicture.asset('assets/icons/camera.svg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const DefaultAppbar(title: 'Personal Information'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfile(isDark),
            const SettingsForm(),
          ],
        ),
      ),
    );
  }
}
