import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class InputField extends StatelessWidget {
  final void Function(String) onSave;
  final String label;
  final TextInputType type;
  final SvgPicture icon;

  // Only for password
  final bool hidePassword;
  final void Function()? onTogglePasswordVisibility;

  const InputField({
    super.key,
    required this.type,
    required this.onSave,
    required this.label,
    required this.icon,
  })  : hidePassword = false,
        onTogglePasswordVisibility = null;

  const InputField.password({
    super.key,
    required this.type,
    required this.onSave,
    required this.label,
    required this.icon,
    required this.hidePassword,
    required this.onTogglePasswordVisibility,
  });

  OutlineInputBorder _buildInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      keyboardType: type,
      obscureText: hidePassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.instrumentSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 14,
            top: 14,
            bottom: 14,
            left: 20,
          ),
          child: icon,
        ),
        suffixIcon: type == TextInputType.visiblePassword
            ? GestureDetector(
                onTap: onTogglePasswordVisibility,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                    top: 12,
                    right: 12,
                    left: 12,
                  ),
                  child: SvgPicture.asset('assets/icons/eye-off.svg'),
                ),
              )
            : null,
        filled: true,
        fillColor:
            AppColors.adaptiveDarkBlueOrWhite(isDark), // Light background color
        focusedBorder: _buildInputBorder(AppColors.accentYellow),
        errorBorder: _buildInputBorder(Colors.red),
        border: _buildInputBorder(AppColors.adaptiveDarkBlueOrWhite(isDark)),
        enabledBorder:
            _buildInputBorder(AppColors.adaptiveDarkBlueOrWhite(isDark)),
        contentPadding: EdgeInsets.symmetric(vertical: 17.5, horizontal: 14),
      ),
      style: GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.adaptiveAccentWhiteOrDeepBlue(isDark),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a valid ${label.toLowerCase()}';
        }
        if (type == TextInputType.emailAddress && !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (newValue) => onSave(newValue!),
    );
  }
}
