import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber;
  String? _password;
  String? _email;
  var hidePassword = true;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    print('registering ...');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        children: [
          InputField(
            type: TextInputType.phone,
            label: 'Number',
            icon: SvgPicture.asset('assets/icons/phone.svg'),
            onSave: (val) => (_phoneNumber = val),
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
