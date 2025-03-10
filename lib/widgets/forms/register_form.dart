import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
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

  void registerWithEmail() async {
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
      final body = json.decode(res.body);

      // Optionally, handle different status codes
      if (res.statusCode == 200 || res.statusCode == 201) {
        // Saving user data on client side
        await LocalStorageHelper.saveUserData(
          token: body['token'],
          email: body['user']['email'],
          fullName: body['user']['full_name'],
        );
      } else {
        throw 'Error: ${res.statusCode}';
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  void trimValues() {
    _name = _name!.trim();
    _email = _email!.trim();
    _password = _password!.trim();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    trimValues();
    registerWithEmail();
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
