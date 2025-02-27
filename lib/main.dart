import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/preference_helper.dart';
import 'package:soluxe/providers/theme_provider.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/screens/personal_info.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final kTheme = ThemeData.light().copyWith(
  textTheme: GoogleFonts.instrumentSansTextTheme(),
  scaffoldBackgroundColor: AppColors.creamWhite,
);
final kDarkTheme = ThemeData.dark().copyWith(
  textTheme: GoogleFonts.instrumentSansTextTheme(),
  scaffoldBackgroundColor: AppColors.deepBlue,
);

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  void _loadTheme() async {
    ref.read(themeProvider.notifier).state = await PreferenceHelper.getTheme();
  }

  @override
  void initState() {
    // Sync App State with Preference
    _loadTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider);

    return MaterialApp(
      theme: kTheme,
      darkTheme: kDarkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: PersonalInfoScreen(),
    );
  }
}
