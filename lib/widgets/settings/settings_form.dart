import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/data/user.dart';
import 'package:soluxe/screens/verification.dart';
import 'package:soluxe/widgets/buttons/yellow_button.dart';
import 'package:soluxe/widgets/inputs/input_field.dart';
import 'package:soluxe/widgets/settings/settings_label.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
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

  @override
  void initState() {
    _name = appUser.name;
    _email = appUser.email!;
    _phoneNumber = appUser.phoneNumber!;
    super.initState();
  }

  void _changeData(String type) {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    if (type == 'email' && _email == appUser.email) return;
    if (type == 'phone' && _phoneNumber == appUser.phoneNumber) return;
    if (type == 'name' && _name == appUser.name) return;

    if (type == 'email') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => VerificationScreen(),
        ),
      );
    } else {
      print('Updating other details like name or phone number');
    }
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
            onComplete: () => _changeData('name'),
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
            onComplete: () => _changeData('email'),
            type: TextInputType.emailAddress,
            onSave: (val) => _email = val,
            label: 'Email',
            initialVal: _email,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            icon: SvgPicture.asset('assets/icons/email.svg'),
          ),
          const SizedBox(height: 16),
          // Row
          _buildLabel('Phone number', isDark),
          const SizedBox(height: 8),
          InputField(
            onComplete: () => _changeData('phone'),
            type: TextInputType.phone,
            onSave: (val) => _phoneNumber = val,
            label: 'Email',
            initialVal: _phoneNumber,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            icon: SvgPicture.asset('assets/icons/phone.svg'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
