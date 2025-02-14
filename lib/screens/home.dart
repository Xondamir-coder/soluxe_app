import 'package:flutter/material.dart';
import 'package:soluxe/widgets/home/home_appbar.dart';
import 'package:soluxe/widgets/home/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: HomeAppbar(
        currentIndex: currentIndex,
        onTap: skip,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      body: HomeBody(
        currentIndex: currentIndex,
        onTap: changeStage,
      ),
    );
  }
}
