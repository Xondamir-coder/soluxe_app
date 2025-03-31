import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/screens/verification.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsForm extends ConsumerStatefulWidget {
  const SettingsForm({super.key});

  @override
  ConsumerState<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends ConsumerState<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  var _name = '';
  var _email = '';
  var _phoneNumber = '';

  Widget _buildLabel(String label, bool isDark) {
    return MyText(
      label,
      color: AppColors.adaptiveAccentWhiteOrDarkerGrey(isDark),
    );
  }

  void _changeData() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    try {
      final token = (await LocalStorageHelper.getAccountData()).token;
      final body = await FetchHelper.fetch(
        url: 'user-edit',
        token: token,
        reqBody: {
          'full_name': _name,
          if (_email.isNotEmpty) 'email': _email,
          if (_phoneNumber.isNotEmpty)
            'phone':
                _phoneNumber.replaceAll('+', '').replaceAll(' ', '').trim(),
        },
        method: HttpMethod.post,
      );
      final isEmail = body['email_must_verify'] as bool;
      if (!mounted) return;
      final msg = isEmail
          ? AppLocalizations.of(context)!.emailUpdated
          : AppLocalizations.of(context)!.phoneUpdated;

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => VerificationScreen(
            isEmail: isEmail,
            successMessage: msg,
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    final acc = ref.read(accountProvider);
    _name = acc.user?.fullName ?? '';
    _email = acc.user?.email ?? '';
    _phoneNumber = acc.user?.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel(AppLocalizations.of(context)!.fullName, isDark),
              InputField(
                type: TextInputType.name,
                onSave: (val) => _name = val,
                label: AppLocalizations.of(context)!.fullName,
                initialVal: _name,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                icon: SvgPicture.asset('assets/icons/profile.svg'),
              ),
            ],
          ),
          if (_email.isNotEmpty)
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel(AppLocalizations.of(context)!.email, isDark),
                InputField(
                  type: TextInputType.emailAddress,
                  onSave: (val) => _email = val,
                  label: AppLocalizations.of(context)!.email,
                  initialVal: _email,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  icon: SvgPicture.asset('assets/icons/email.svg'),
                ),
              ],
            ),
          if (_phoneNumber.isNotEmpty)
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel(AppLocalizations.of(context)!.phone, isDark),
                InputField(
                  type: TextInputType.phone,
                  onSave: (val) => _phoneNumber = val,
                  label: AppLocalizations.of(context)!.phone,
                  initialVal: _phoneNumber,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  icon: SvgPicture.asset('assets/icons/phone.svg'),
                ),
              ],
            ),
          YellowButton(
            AppLocalizations.of(context)!.submit,
            onTap: _changeData,
          ),
        ],
      ),
    );
  }
}
