import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/models/user.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/screens/verification.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/my_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      await FetchHelper.sendCode(true, _email!);

      // Update state/storage
      final accountNotifier = ref.read(accountProvider.notifier);
      accountNotifier.updateAccount(user: User(email: _email));

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => VerificationScreen(
            isEmail: true,
            successMessage:
                AppLocalizations.of(context)!.successfullyConfirmedEmail,
          ),
        ),
      );
    } catch (e) {
      final localeName = AppLocalizations.of(context)!.localeName;
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
          message:
              '${(e as Map)['body'][localeName] ?? (e)['body']['message']}',
        ),
      );
    }
  }

  void _registerWithEmail() async {
    try {
      await FetchHelper.fetch(
        url: 'register',
        method: HttpMethod.post,
        reqBody: {
          'full_name': _name,
          'email': _email,
          'password': _password,
          'auth_provider': 'email',
        },
      );
    } catch (e) {
      if ((e as Map)['code'] == 401) {
        _sendVerificationCode();
        return;
      }

      if (!mounted) return;
      final localeName = AppLocalizations.of(context)!.localeName;
      showDialog(
        context: context,
        builder: (ctx) => MyDialog(
            message: '${(e)['body'][localeName] ?? (e)['body']['message']}'),
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
            label: AppLocalizations.of(context)!.fullName,
            icon: SvgPicture.asset('assets/icons/profile.svg'),
            onSave: (val) => (_name = val),
          ),
          InputField(
            type: TextInputType.emailAddress,
            label: AppLocalizations.of(context)!.email,
            icon: SvgPicture.asset('assets/icons/email.svg'),
            onSave: (val) => (_email = val),
          ),
          InputField.password(
            type: TextInputType.visiblePassword,
            label: AppLocalizations.of(context)!.password,
            icon: SvgPicture.asset('assets/icons/lock.svg'),
            hidePassword: hidePassword,
            onSave: (val) => (_password = val),
            onTogglePasswordVisibility: () =>
                setState(() => hidePassword = !hidePassword),
          ),
          YellowButton(AppLocalizations.of(context)!.next, onTap: _submitForm),
        ],
      ),
    );
  }
}
