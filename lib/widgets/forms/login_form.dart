import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/models/user.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/screens/forgot_password.dart';
import 'package:soluxe/screens/home.dart';
import 'package:soluxe/screens/verification.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/my_dialog.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends ConsumerStatefulWidget {
  final bool isEmail;

  const LoginForm({super.key, required this.isEmail});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _login;
  String? _password;
  var hidePassword = true;

  void _forgotPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ForgotPasswordScreen(),
      ),
    );
  }

  void _showMsg(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => MyDialog(message: message),
    );
  }

  void _sendVerificationCode() async {
    try {
      // Send code to email/phone
      await FetchHelper.sendCode(widget.isEmail, _login!);

      // Verify email/phone
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => VerificationScreen(
            isEmail: widget.isEmail,
            login: _login!,
            successMessage: AppLocalizations.of(context)!.successfullyLoggedIn,
          ),
        ),
      );
    } catch (e) {
      final localeName = AppLocalizations.of(context)!.localeName;
      _showMsg((e as Map)['body'][localeName] ?? (e)['body']['message']);
    }
  }

  void _serverLogin() async {
    try {
      // Login
      final body = await FetchHelper.fetch(
        url: 'login',
        method: HttpMethod.post,
        reqBody: {
          widget.isEmail ? 'email' : 'phone': _login,
          'password': _password,
          'auth_provider': widget.isEmail ? 'email' : 'phone',
        },
      );

      // Update state/storage
      final accountNotifier = ref.read(accountProvider.notifier);
      accountNotifier.updateAccount(
        token: body['token'] as String,
        user: User.fromMap(body['user'] as Map<String, dynamic>),
      );

      // Navigate to home
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const HomeScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      // If the email/phone isn't confirmed
      if ((e as Map)['code'] == 401) {
        _sendVerificationCode();
      } else {
        final localeName = AppLocalizations.of(context)!.localeName;
        _showMsg((e)['body'][localeName] ?? (e)['body']['message']);
      }
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    _serverLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          Column(
            spacing: 16,
            children: [
              InputField(
                type: widget.isEmail
                    ? TextInputType.emailAddress
                    : TextInputType.phone,
                label: widget.isEmail
                    ? AppLocalizations.of(context)!.email
                    : AppLocalizations.of(context)!.phone,
                icon: SvgPicture.asset(widget.isEmail
                    ? 'assets/icons/email.svg'
                    : 'assets/icons/phone.svg'),
                onSave: (val) => (_login = val),
              ),
              InputField.password(
                type: TextInputType.visiblePassword,
                label: AppLocalizations.of(context)!.password,
                icon: SvgPicture.asset('assets/icons/lock.svg'),
                hidePassword: hidePassword,
                onSave: (val) => (_password = val),
                onTogglePasswordVisibility: () =>
                    setState(() => hidePassword = !hidePassword),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: _forgotPassword,
              child: MyText.deepBlue(
                  '${AppLocalizations.of(context)!.forgotPassword}?'),
            ),
          ),
          YellowButton(AppLocalizations.of(context)!.next, onTap: _submitForm),
        ],
      ),
    );
  }
}
