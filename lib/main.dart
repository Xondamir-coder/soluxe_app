import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/explore.dart';
import 'package:soluxe/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final kTheme = ThemeData().copyWith(
  scaffoldBackgroundColor: AppColors.creamWhite,
  textTheme: GoogleFonts.instrumentSansTextTheme(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
