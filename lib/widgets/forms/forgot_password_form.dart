import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/screens/reset_password.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/my_dialog.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class ForgotPasswordForm extends ConsumerStatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  ConsumerState<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends ConsumerState<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;

  void _sendCode() async {
    try {
      await FetchHelper.sendCode(true, _email!);

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ResetPasswordScreen(email: _email!),
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

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    _sendCode();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputField(
            type: TextInputType.emailAddress,
            onSave: (val) => _email = val,
            label: AppLocalizations.of(context)!.email,
            icon: SvgPicture.asset('assets/icons/email.svg'),
          ),
          Spacer(),
          YellowButton(AppLocalizations.of(context)!.next, onTap: _submitForm)
        ],
      ),
    );
  }
}
