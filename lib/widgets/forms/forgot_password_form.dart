import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/screens/reset_password.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/my_dialog.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;

  void _sendCode() async {
    try {
      await FetchHelper.sendCode(true, _email!);

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ResetPasswordScreen(),
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
