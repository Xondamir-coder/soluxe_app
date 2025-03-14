import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/screens/success.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/my_dialog.dart';

class ResetPasswordForm extends ConsumerStatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  ConsumerState<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _emailCode;
  String? _newPassword;

  var _hideNewPassword = true;

  void _serverResetPassword() async {
    try {
      await FetchHelper.fetch(
        url: '${Constants.apiUrl}/confirm-forget-password',
        method: HttpMethod.post,
        reqBody: {
          'email': ref.read(accountProvider).user!.email!,
          'email_verified_code': _emailCode,
          'password': _newPassword,
        },
      );

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SuccessScreen(text: 'Password reset successfully'),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
            message: '${(e as Map)['body']['en'] ?? (e)['body']['message']}'),
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
            label: 'Email code',
            icon: SvgPicture.asset('assets/icons/email.svg'),
          ),
          InputField.password(
            type: TextInputType.visiblePassword,
            onSave: (val) => _newPassword = val,
            label: 'New Password',
            icon: SvgPicture.asset('assets/icons/lock.svg'),
            hidePassword: _hideNewPassword,
            onTogglePasswordVisibility: () =>
                setState(() => _hideNewPassword = !_hideNewPassword),
          ),
          Spacer(),
          YellowButton('Reset', onTap: _resetPassword),
        ],
      ),
    );
  }
}
