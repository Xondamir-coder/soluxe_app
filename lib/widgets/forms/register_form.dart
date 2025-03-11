import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/screens/verification.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:http/http.dart' as http;

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _password;
  String? _email;
  var hidePassword = true;

  void _sendVerificationCode() async {
    // Send email verification code
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
          builder: (ctx) => VerificationScreen(
            isEmail: true,
            successMessage: 'You have successfully confirmed your email',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred. Try again')),
      );
    }
  }

  void _registerWithEmail() async {
    try {
      final res = await http.post(
        Uri.parse('${Constants.baseUrl}/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'full_name': _name,
          'email': _email,
          'password': _password,
          'auth_provider': 'email',
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        _sendVerificationCode();
      } else {
        throw 'Error: ${res.statusCode}';
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred. Try again')),
      );
    }
  }

  void _trimValues() {
    _name = _name!.trim();
    _email = _email!.trim();
    _password = _password!.trim();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    _trimValues();
    _registerWithEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        children: [
          InputField(
            type: TextInputType.name,
            label: 'Name',
            icon: SvgPicture.asset('assets/icons/profile.svg'),
            onSave: (val) => (_name = val),
          ),
          InputField(
            type: TextInputType.emailAddress,
            label: 'Email',
            icon: SvgPicture.asset('assets/icons/email.svg'),
            onSave: (val) => (_email = val),
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
          YellowButton('Next', onTap: _submitForm),
        ],
      ),
    );
  }
}
