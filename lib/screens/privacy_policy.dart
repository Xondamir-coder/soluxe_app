import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/policy.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final testPolicy = Policy(
  title: 'Dui efficitur ridiculus ridiculus nam est risus senectus',
  text:
      'Lorem ipsum odor amet, consectetuer adipiscing elit. Semper arcu cubilia tellus rutrum iaculis tincidunt volutpat urna. Duis quisque ad sit commodo tellus suscipit. Imperdiet fringilla viverra accumsan ultricies odio tempor nisi mollis aliquet. Cursus proin natoque amet; at facilisis turpis volutpat facilisi. Diam netus ligula quis aptent leo aenean montes mauris. Semper ex auctor imperdiet aenean magnis inceptos curae finibus. Condimentum condimentum odio finibus convallis taciti suspendisse congue tincidunt. Maximus fermentum condimentum eget congue pretium massa velit lacinia.',
);
final policies = List.generate(8, (index) => testPolicy);

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: DefaultAppbar(title: AppLocalizations.of(context)!.privacyPolicy),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.adaptiveDarkBlueOrWhite(isDark),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                children: [
                  for (var i = 0; i < policies.length; i++)
                    Column(
                      spacing: 8,
                      children: [
                        MyText.deepBlue('${i + 1}. ${policies[i].title}',
                            fontSize: 16),
                        MyText(
                          policies[i].text,
                          color: AppColors.adaptiveGreyOrDarkGrey(isDark),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
