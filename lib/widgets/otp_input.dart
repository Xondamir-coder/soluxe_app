import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class OtpInput extends StatefulWidget {
  final void Function(List<String>) onChangeOtpValues;

  const OtpInput({super.key, required this.onChangeOtpValues});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());
  final List<String> otpValues = List.filled(5, ""); // Stores OTP values

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      otpValues[index] = value; // Store value
      if (index < 4) {
        FocusScope.of(context)
            .requestFocus(focusNodes[index + 1]); // Move to next field
      } else {
        FocusScope.of(context).unfocus(); // Hide keyboard on last input
      }
    } else {
      otpValues[index] = ""; // Remove value if empty
    }
    widget.onChangeOtpValues(otpValues);
  }

  void _onKeyPressed(KeyEvent event, int index) {
    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        otpValues[index].isEmpty &&
        index > 0) {
      FocusScope.of(context)
          .requestFocus(focusNodes[index - 1]); // Move focus back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: SizedBox(
            width: 56,
            height: 56,
            child: KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (event) => _onKeyPressed(event, index),
              child: TextFormField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: GoogleFonts.instrumentSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepBlue,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10), // Center vertically
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFFC4A45F), width: 2),
                  ),
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            ),
          ),
        );
      }),
    );
  }
}
