import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/helpers/fetch_helper.dart';
import 'package:soluxe/helpers/local_storage_helper.dart';
import 'package:soluxe/models/user.dart';
import 'package:soluxe/providers/account_provider.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

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
          'email': _email,
          'phone': _phoneNumber.replaceAll('+', '').replaceAll(' ', '').trim(),
        },
        method: HttpMethod.post,
      );
      ref.read(accountProvider.notifier).updateAccount(
            user: User.fromMap(body['user'] as Map<String, dynamic>),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row
          _buildLabel('Full name', isDark),
          const SizedBox(height: 8),
          InputField(
            type: TextInputType.name,
            onSave: (val) => _name = val,
            label: 'Full Name',
            initialVal: _name,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            icon: SvgPicture.asset('assets/icons/profile.svg'),
          ),
          const SizedBox(height: 16),

          // Row
          _buildLabel('Email', isDark),
          const SizedBox(height: 8),
          InputField(
            type: TextInputType.emailAddress,
            onSave: (val) => _email = val,
            label: 'Email',
            initialVal: _email,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            icon: SvgPicture.asset('assets/icons/email.svg'),
          ),
          const SizedBox(height: 16),

          // Row
          _buildLabel('Phone', isDark),
          const SizedBox(height: 8),
          InputField(
            type: TextInputType.phone,
            onSave: (val) => _phoneNumber = val,
            label: 'Phone',
            initialVal: _phoneNumber,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            icon: SvgPicture.asset('assets/icons/phone.svg'),
          ),
          const SizedBox(height: 16),
          YellowButton(
            'Submit',
            onTap: _changeData,
          ),
        ],
      ),
    );
  }
}
