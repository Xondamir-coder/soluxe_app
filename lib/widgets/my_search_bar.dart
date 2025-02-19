import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soluxe/constants/colors.dart';

class MySearchBar extends StatefulWidget {
  final String label;
  final void Function(String) onSearch;

  const MySearchBar({
    super.key,
    required this.label,
    required this.onSearch,
  });

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final _textController = TextEditingController();
  final ValueNotifier<bool> _showClearIcon = ValueNotifier<bool>(false);

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
  void initState() {
    super.initState();
    _textController.addListener(() {
      _showClearIcon.value = _textController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _showClearIcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        widget.onSearch(_textController.text);
      },
      style: GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.deepBlue,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 14,
            top: 14,
            bottom: 14,
            left: 20,
          ),
          child: SvgPicture.asset('assets/icons/search.svg'),
        ),
        suffixIcon: ValueListenableBuilder<bool>(
          valueListenable: _showClearIcon,
          builder: (context, show, child) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: show
                  ? Container(
                      key: ValueKey('clearIcon'), // Ensures animation triggers
                      alignment: Alignment.centerRight,
                      width: 30,
                      height: 30,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _textController.clear();
                          _showClearIcon.value = false;
                          FocusScope.of(context).unfocus();
                        },
                        icon: SvgPicture.asset('assets/icons/x.svg'),
                      ),
                    )
                  : SizedBox.shrink(), // Ensures animation plays smoothly
            );
          },
        ),
        labelText: widget.label,
        labelStyle: GoogleFonts.instrumentSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ),
        filled: true,
        fillColor: Colors.white,
        border: _buildInputBorder(Colors.white),
        enabledBorder: _buildInputBorder(Colors.white),
        focusedBorder: _buildInputBorder(AppColors.accentYellow),
      ),
    );
  }
}
