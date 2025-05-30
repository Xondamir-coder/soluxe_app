import 'package:flutter/material.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/screens/welcome.dart';

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
