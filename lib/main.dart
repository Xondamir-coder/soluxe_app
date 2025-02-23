import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/events.dart';
import 'package:soluxe/screens/faq/faq.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(child: const MyApp()),
  );
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
      home: const EventsScreen(),
    );
  }
}
