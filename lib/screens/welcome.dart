import 'package:flutter/material.dart';
import 'package:soluxe/widgets/appbars/welcome_appbar.dart';
import 'package:soluxe/widgets/welcome/welcome_body.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentIndex = 0;

  void skip() {
    setState(() {
      currentIndex = 4;
    });
  }

  void changeStage() {
    setState(() {
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WelcomeAppbar(
        currentIndex: currentIndex,
        onTap: skip,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      body: WelcomeBody(
        currentIndex: currentIndex,
        onTap: changeStage,
      ),
    );
  }
}
