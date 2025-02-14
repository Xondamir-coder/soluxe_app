import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/screens/verification.dart';
import 'package:soluxe/widgets/input_field.dart';
import 'package:soluxe/widgets/buttons/provider_button.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber;
  String? _password;
  var hidePassword = true;

  void _forgotPassword() {
    print('forgot');
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => VerificationScreen(),
      ),
    );
  }

  void _signInWithProvider(String name) {
    print(name);
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
                type: TextInputType.phone,
                label: 'Number',
                icon: SvgPicture.asset('assets/icons/phone.svg'),
                onSave: (val) => (_phoneNumber = val),
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
              child: MyText(
                'Forgot Password?',
                color: AppColors.deepBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          YellowButton('Next', onTap: _submitForm),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.softWhite.withValues(alpha: 0),
                        AppColors.softWhite.withValues(alpha: 1),
                      ],
                    ),
                  ),
                ),
              ),
              MyText('Or', color: AppColors.grey),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.softWhite.withValues(alpha: 1),
                        AppColors.softWhite.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ProviderButton(
            'Sign In with Google',
            onTap: () => _signInWithProvider('google'),
            icon: SvgPicture.asset('assets/icons/google.svg'),
          ),
          ProviderButton(
            'Sign In with Apple',
            onTap: () => _signInWithProvider('apple'),
            icon: SvgPicture.asset('assets/icons/apple.svg'),
          ),
        ],
      ),
    );
  }
}
