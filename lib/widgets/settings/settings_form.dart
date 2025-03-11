import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/user_provider.dart';
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

  void _initData() {
    final user = ref.read(userProvider);
    _name = user.name!;
    _email = user.email!;
    _phoneNumber = user.phoneNumber!;
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _changeData(String type) {
    if (!_formKey.currentState!.validate()) return;

    final user = ref.read(userProvider);

    _formKey.currentState!.save();

    if (type == 'email' && _email == user.email) return;
    if (type == 'phone' && _phoneNumber == user.phoneNumber) return;
    if (type == 'name' && _name == user.name) return;

    if (type == 'email') {
      // TODO:

      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (ctx) => VerificationScreen(),
      //   ),
      // );
    } else {
      print('Updating other details like name or phone number');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    ref.watch(userProvider);

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
