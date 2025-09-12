import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/models/account.dart';
import 'package:soluxe/models/user.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/screens/success.dart';
import 'package:soluxe/widgets/animations/scale_up_widget.dart';
import 'package:soluxe/widgets/appbars/arrow_appbar.dart';
import 'package:soluxe/widgets/inputs/otp_input.dart';
import 'package:soluxe/widgets/my_dialog.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/typography/my_title.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class VerificationScreen extends ConsumerWidget {
  final bool isEmail;
  final String successMessage;
  final String login;
  final List<String> otpValues = [];

  VerificationScreen({
    super.key,
    required this.isEmail,
    required this.login,
    required this.successMessage,
  });

  // Stores OTP values
  void populatOtpValues(List<String> values) {
    otpValues.clear();
    otpValues.addAll(values);
  }

  void _resendCode(BuildContext context, Account account) async {
    try {
      await FetchHelper.sendCode(
        isEmail,
        login,
      );

      // Show success message
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
          message: AppLocalizations.of(context)!.codeHasBeenSent,
        ),
      );
    } catch (e) {
      final localeName = AppLocalizations.of(context)!.localeName;
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
            message:
                '${(e as Map)['body'][localeName] ?? (e)['body']['message']}'),
      );
    }
  }

  void _serverVerifyCode(
    BuildContext context,
    Account account,
    WidgetRef ref,
  ) async {
    try {
      final body = await FetchHelper.verifyCode(
        isEmail,
        login,
        otpValues.join(''),
      );

      // Update state/storage
      final accountNotifier = ref.read(accountProvider.notifier);
      accountNotifier.updateAccount(
        token: body['token'] as String,
        user: User.fromMap(body['user'] as Map<String, dynamic>),
      );

      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SuccessScreen(text: successMessage),
        ),
      );
    } catch (e) {
      final localeName = AppLocalizations.of(context)!.localeName;
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
            message:
                '${(e as Map)['body'][localeName] ?? (e)['body']['message']}'),
      );
    }
  }

  void _verifyCode(BuildContext context, Account account, WidgetRef ref) async {
    if (otpValues.every((code) => code.isNotEmpty)) {
      _serverVerifyCode(context, account, ref);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
          message: AppLocalizations.of(context)!.enterAllCodes,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final account = ref.watch(accountProvider);

    return Scaffold(
      appBar: ArrowAppbar(
        backgroundColor: AppColors.adaptiveTransparentBg(isDark),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: .2,
              child: SvgPicture.asset(
                'assets/vectors/pattern.svg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 36,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScaleUpWidget.fade(
                    child: SvgPicture.asset(
                      isDark
                          ? 'assets/icons/verification-dark.svg'
                          : 'assets/icons/verification.svg',
                    ),
                  ),
                  const SizedBox(height: 40),
                  MyTitle(AppLocalizations.of(context)!.verificationCode),
                  const SizedBox(height: 8),
                  Column(
                    spacing: 3,
                    children: [
                      MyText.warmPrimary(
                        AppLocalizations.of(context)!
                            .weAreSendingVerificationCodeTo,
                        beginOffset: Offset(0, 1.5),
                        animationDelay: 200,
                      ),
                      MyText.deepBlue(
                        login,
                        animationDelay: 300,
                        beginOffset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ScaleUpWidget.fade(
                    beginScale: 0.75,
                    delay: 400,
                    child: OtpInput(
                      onChangeOtpValues: (vals) => populatOtpValues(vals),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () => _resendCode(context, account),
                    style: TextButton.styleFrom(
                      overlayColor: AppColors.primary,
                    ),
                    child: MyText(
                      AppLocalizations.of(context)!.resendOTPCode,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      animationDelay: 500,
                      beginOffset: Offset(0, 1),
                    ),
                  ),
                  Spacer(),
                  YellowButton(
                    AppLocalizations.of(context)!.next,
                    onTap: () => _verifyCode(context, account, ref),
                    animationDelay: 600,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
