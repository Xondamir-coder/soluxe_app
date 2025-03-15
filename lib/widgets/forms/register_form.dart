import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/models/account.dart';
import 'package:soluxe/models/user.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/screens/verification.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/my_dialog.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _password;
  String? _email;
  var hidePassword = true;

  void _sendVerificationCode() async {
    try {
      final body = await FetchHelper.sendCode(true, _email!);

      print('Send code: $body');

      // Update state/storage
      final accountNotifier = ref.read(accountProvider.notifier);
      accountNotifier.updateAccount(user: User(email: _email));

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
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
          message: '${(e as Map)['body']['en'] ?? (e)['body']['message']}',
        ),
      );
    }
  }

  void _registerWithEmail() async {
    try {
      final body = await FetchHelper.fetch(
        url: 'register',
        method: HttpMethod.post,
        reqBody: {
          'full_name': _name,
          'email': _email,
          'password': _password,
          'auth_provider': 'email',
        },
      );
      print('Register: $body');
    } catch (e) {
      if ((e as Map)['code'] == 401) {
        _sendVerificationCode();
        return;
      }

      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) =>
            MyDialog(message: '${(e)['body']['en'] ?? (e)['body']['message']}'),
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
