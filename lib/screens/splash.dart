import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/helpers/preference_helper.dart';
import 'package:soluxe/screens/privacy_policy.dart';
import 'package:soluxe/screens/welcome.dart';
import 'package:soluxe/l10n/app_localizations.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _splashVisible = true;
  bool _isLoggedIn = false;

  void _checkLogin() async {
    final data = await LocalStorageHelper.getAccountData();
    final isValid = data.token != null &&
        data.user != null &&
        data.user?.fullName != null &&
        (data.user?.email != null || data.user?.phone != null);
    if (isValid) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  void _showConsentDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: MyText.warmPrimary(
          AppLocalizations.of(context)!.privacyPolicy,
          fontSize: 22,
        ),
        content: MyText(
          AppLocalizations.of(context)!.consentText,
          fontSize: 14,
          color: isDark ? AppColors.lightPrimary : AppColors.darkPrimary,
        ),
        actions: [
          YellowButton(
            AppLocalizations.of(context)!.agree,
            onTap: () {
              PreferenceHelper.saveConsent(true);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const PrivacyPolicyScreen(),
              ),
            ),
            child: MyText(AppLocalizations.of(context)!.viewPolicy),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();

    // Create the controller for a 500ms animation.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Define the fade animation: fully visible to invisible.
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    // Define the scale animation: normal size to slightly larger.
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);

    // Start the animation after a 2-second delay.
    Future.delayed(const Duration(seconds: 3), () {
      _controller.forward().then((_) {
        setState(() {
          _splashVisible = false; // Remove the splash overlay.
        });
        _showConsentDialog();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // HomeScreen as the bottom layer.
        if (_isLoggedIn) const HomeScreen(),
        if (!_isLoggedIn) const WelcomeScreen(),

        // Only show the splash screen overlay if it's still visible.
        if (_splashVisible)
          Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              // Your original splash content.
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/splash.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: .65,
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
