import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/locale_provider.dart';
import 'package:soluxe/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:soluxe/screens/splash.dart';

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
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      theme: kTheme,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: kDarkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
