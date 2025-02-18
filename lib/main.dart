import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

final kTheme = ThemeData().copyWith(
  scaffoldBackgroundColor: AppColors.creamWhite,
  textTheme: GoogleFonts.instrumentSansTextTheme(),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kTheme,
      debugShowCheckedModeBanner: false,
      home: const SettingsScreen(),
    );
  }
}
