import 'package:flutter/material.dart';
import 'package:soluxe/widgets/login/login_appbar.dart';
import 'package:soluxe/widgets/login/login_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentIndex = 0;

  void changeStage() {
    setState(() {
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppbar(currentIndex: currentIndex),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      body: LoginBody(
        currentIndex: currentIndex,
        onTap: changeStage,
      ),
    );
  }
}
