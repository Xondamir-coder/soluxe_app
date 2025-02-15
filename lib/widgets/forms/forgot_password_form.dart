import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/screens/reset_password.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;

  void _submitForm() {
    print('submitting email');
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ResetPasswordScreen(),
      ),
    );
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
            label: 'Email',
            icon: SvgPicture.asset('assets/icons/email.svg'),
          ),
          Spacer(),
          YellowButton('Next', onTap: _submitForm)
        ],
      ),
    );
  }
}
