import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _otpPassword;
  String? _newPassword;

  var _hideOldPassword = true;
  var _hideNewPassword = true;

  void _resetPassword() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    print('resetting ...');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        children: [
          InputField.password(
            type: TextInputType.visiblePassword,
            onSave: (val) => _otpPassword = val,
            label: 'Otp Password',
            icon: SvgPicture.asset('assets/icons/lock.svg'),
            hidePassword: _hideOldPassword,
            onTogglePasswordVisibility: () =>
                setState(() => _hideOldPassword = !_hideOldPassword),
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
