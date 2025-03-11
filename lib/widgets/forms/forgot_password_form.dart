import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/screens/reset_password.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:http/http.dart' as http;

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
      final res = await http.post(
        Uri.parse('${Constants.baseUrl}/email-send'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'email': _email,
          },
        ),
      );

      if (res.statusCode != 200 || res.statusCode != 201) {
        throw 'Error: ${res.statusCode}';
      }

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const ResetPasswordScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error occurred. Try again')));
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
