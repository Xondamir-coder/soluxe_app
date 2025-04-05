import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/screens/success.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/my_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordForm extends ConsumerStatefulWidget {
   final String email;

  const ResetPasswordForm({super.key, required this.email});

  @override
  ConsumerState<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _emailCode;
  String? _newPassword;

  var _hideNewPassword = true;

  void _serverResetPassword() async {
    final localeName = AppLocalizations.of(context)!.localeName;

    try {
      final body = await FetchHelper.fetch(
        url: 'confirm-forget-password',
        method: HttpMethod.post,
        reqBody: {
          'email': widget.email,
          'email_verified_code': _emailCode,
          'password': _newPassword,
        },
      );

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SuccessScreen(
            text: body[localeName] as String,
            goLogin: true,
          ),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
            message:
                '${(e as Map)['body'][localeName] ?? (e)['body']['message']}'),
      );
    }
  }

  void _resetPassword() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    _serverResetPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        children: [
          InputField(
            type: TextInputType.text,
            onSave: (val) => _emailCode = val,
            label: AppLocalizations.of(context)!.emailCode,
            icon: SvgPicture.asset('assets/icons/email.svg'),
          ),
          InputField.password(
            type: TextInputType.visiblePassword,
            onSave: (val) => _newPassword = val,
            label: AppLocalizations.of(context)!.newPassword,
            icon: SvgPicture.asset('assets/icons/lock.svg'),
            hidePassword: _hideNewPassword,
            onTogglePasswordVisibility: () =>
                setState(() => _hideNewPassword = !_hideNewPassword),
          ),
          Spacer(),
          YellowButton(AppLocalizations.of(context)!.reset,
              onTap: _resetPassword),
        ],
      ),
    );
  }
}
