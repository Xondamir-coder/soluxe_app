import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/screens/forgot_password.dart';
import 'package:soluxe/screens/verification.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  final bool isEmail;

  const LoginForm({super.key, required this.isEmail});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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

  void _serverLogin() async {
    try {
      final res = await http.post(
        Uri.parse('${Constants.baseUrl}/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          widget.isEmail ? 'email' : 'phone': _login,
          'password': _password,
          'auth_provider': widget.isEmail ? 'email' : 'phone',
        }),
      );

      if (res.statusCode != 200 || res.statusCode != 201) {
        throw json.decode(res.body)['en'];
      }

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => VerificationScreen(
            isEmail: widget.isEmail,
            successMessage: 'Successfully logged in',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
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
                label: widget.isEmail ? 'Email' : 'Number',
                icon: SvgPicture.asset(widget.isEmail
                    ? 'assets/icons/email.svg'
                    : 'assets/icons/phone.svg'),
                onSave: (val) => (_login = val),
              ),
              InputField.password(
                type: TextInputType.visiblePassword,
                label: 'Password',
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
              child: MyText.deepBlue('Forgot Password?'),
            ),
          ),
          YellowButton('Next', onTap: _submitForm),
        ],
      ),
    );
  }
}
