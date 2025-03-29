import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/theme_provider.dart';
import 'package:soluxe/screens/explore.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/screens/hotels.dart';
import 'package:soluxe/screens/personal_info.dart';
import 'package:soluxe/screens/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

final kTheme = ThemeData.light().copyWith(
  textTheme: GoogleFonts.instrumentSansTextTheme(),
  scaffoldBackgroundColor: AppColors.creamWhite,
);
final kDarkTheme = ThemeData.dark().copyWith(
  textTheme: GoogleFonts.instrumentSansTextTheme(),
  scaffoldBackgroundColor: AppColors.deepBlue,
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return MaterialApp(
      theme: kTheme,
      darkTheme: kDarkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      home: SettingsScreen(),
    );
  }
}
