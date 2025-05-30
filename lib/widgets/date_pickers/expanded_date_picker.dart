import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/constants/constants.dart';
import 'package:soluxe/models/date_entry.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpandedDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<String> onDateChange;
  final bool isMonthCentered;
  final bool darkBlueBgColor;
  final List<DateEntry> dateEntries;

  const ExpandedDatePicker({
    super.key,
    required this.onDateChange,
    required this.date,
    required this.dateEntries,
    this.isMonthCentered = false,
    this.darkBlueBgColor = false,
  });

  @override
  State<ExpandedDatePicker> createState() => _ExpandedDatePickerState();
}

class _ExpandedDatePickerState extends State<ExpandedDatePicker> {
  double _opacity = 1.0; // Controls smooth fading

  /// Changes the displayed month with a smooth transition
  void _changeMonth(int direction) async {
    setState(() {
      _opacity = 0.0; // Fade out first
    });

    await Future.delayed(Duration(milliseconds: 200)); // Wait for fade-out

    int targetYear = widget.date.year;
    int targetMonth = widget.date.month + direction;

    if (targetMonth < 1) {
      targetYear -= 1;
      targetMonth = 12;
    } else if (targetMonth > 12) {
      targetYear += 1;
      targetMonth = 1;
    }

    int daysInTargetMonth = DateTime(targetYear, targetMonth + 1, 0).day;
    int newDay = widget.date.day > daysInTargetMonth
        ? daysInTargetMonth
        : widget.date.day;

    final newDate = DateTime(targetYear, targetMonth, newDay);
    widget.onDateChange(DateFormat('yyyy-MM-dd').format(newDate));
    _opacity = 1.0; // Fade in after state update
  }

  /// Builds the calendar grid for the current month
  Widget _buildCalendar(bool isDark) {
    DateTime firstDayOfMonth = DateTime(widget.date.year, widget.date.month, 1);
    int startingWeekday = firstDayOfMonth.weekday;
    int daysInMonth = DateTime(widget.date.year, widget.date.month + 1, 0).day;

    List<Widget> dayWidgets = [];
    int dayCounter = 1;
    int totalWeeks = ((startingWeekday - 1 + daysInMonth) / 7).ceil();

    for (int i = 0; i < totalWeeks; i++) {
      List<Widget> weekRow = [];

      for (int j = 1; j <= 7; j++) {
        if ((i == 0 && j < startingWeekday) || dayCounter > daysInMonth) {
          weekRow.add(Expanded(child: SizedBox()));
        } else {
          DateTime day =
              DateTime(widget.date.year, widget.date.month, dayCounter);
          bool isSelected = day.day == widget.date.day;
          final dateEntry = widget.dateEntries.isNotEmpty
              ? widget.dateEntries[day.day - 1]
              : null;

          weekRow.add(
            Expanded(
              child: Container(
                margin: EdgeInsets.all(3),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : widget.darkBlueBgColor
                            ? AppColors.adaptiveDarkBlueOrAlmostWhite(isDark)
                            : AppColors.adaptiveDeepBlueOrAlmostWhite(isDark),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _selectDate(day),
                      borderRadius: BorderRadius.circular(8),
                      splashColor: AppColors.primary.withValues(alpha: 0.2),
                      highlightColor: AppColors.primary.withValues(alpha: 0.1),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Column(
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: GoogleFonts.instrumentSans(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.adaptiveAccentWhiteOrDeepBlue(
                                        isDark),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              child: Text('${day.day}'),
                            ),
                            SizedBox(height: 4),
                            if (dateEntry?.exists ?? false)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
          dayCounter++;
        }
      }

      dayWidgets.add(Row(children: weekRow));
    }

    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: _opacity,
      child: Column(
        children: dayWidgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Month & Navigation Row
        Row(
          spacing: 10,
          mainAxisAlignment: widget.isMonthCentered
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Material(
              color: widget.darkBlueBgColor
                  ? AppColors.adaptiveDarkBlueOrLightGrey(isDark)
                  : AppColors.adaptiveTransparentOrLightGrey(isDark),
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _changeMonth(-1),
                child: Container(
                  width: 36,
                  height: 36,
                  padding: EdgeInsets.all(9),
                  child: SvgPicture.asset(
                    'assets/icons/arrow-left.svg',
                    colorFilter: ColorFilter.mode(
                      AppColors.adaptiveGreyOrDarkGrey(isDark),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            MyText.deepBlue(
              DateFormat('MMMM yyyy', AppLocalizations.of(context)!.localeName)
                  .format(widget.date),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            Material(
              color: widget.darkBlueBgColor
                  ? AppColors.adaptiveDarkBlueOrLightGrey(isDark)
                  : AppColors.adaptiveTransparentOrLightGrey(isDark),
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _changeMonth(1),
                child: Container(
                  width: 36,
                  height: 36,
                  padding: EdgeInsets.all(9),
                  child: SvgPicture.asset(
                    'assets/icons/arrow-right.svg',
                    colorFilter: ColorFilter.mode(
                      AppColors.adaptiveGreyOrDarkGrey(isDark),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        // Weekday Headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: (AppLocalizations.of(context)!.localeName == 'zh'
                  ? Constants.weekdaysLettersZh
                  : Constants.weekdaysLettersEn)
              .map(
                (day) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MyText(
                    day,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.adaptiveGreyOrDarkGrey(isDark),
                  ),
                ),
              )
              .toList(),
        ),

        // Calendar Grid
        _buildCalendar(isDark),
      ],
    );
  }

  /// Selects a new date and calls `onDateChange`
  void _selectDate(DateTime date) {
    widget.onDateChange(DateFormat('yyyy-MM-dd').format(date));
  }
}
