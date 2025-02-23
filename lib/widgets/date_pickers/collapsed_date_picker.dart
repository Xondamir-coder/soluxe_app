import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class CollapsedDatePicker extends StatelessWidget {
  final DateTime date;
  final void Function() onExpandCalendar;
  final ValueChanged<DateTime> onDateChange;

  const CollapsedDatePicker({
    super.key,
    required this.date,
    required this.onExpandCalendar,
    required this.onDateChange,
  });

  /// Build a list of all days in the current month
  List<DateTime> _buildDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay =
        DateTime(month.year, month.month + 1, 0); // 0 -> last day of prev month

    final days = <DateTime>[];
    var temp = firstDay;
    while (!temp.isAfter(lastDay)) {
      days.add(temp);
      temp = temp.add(const Duration(days: 1));
    }
    return days;
  }

  /// Shifts the current date by [monthOffset] months.
  /// For a negative offset, it goes to previous months,
  /// and for a positive offset, it goes to next months.
  void _shiftMonth(int monthOffset) {
    int newYear = date.year;
    int newMonth = date.month + monthOffset;

    if (newMonth < 1) {
      newMonth = 12;
      newYear -= 1;
    } else if (newMonth > 12) {
      newMonth = 1;
      newYear += 1;
    }

    final newDate = DateTime(newYear, newMonth, date.day);
    onDateChange(newDate);
  }

  /// Builds the horizontal list of days for a given [month].
  Widget _buildDaysRow(DateTime month) {
    final days = _buildDaysInMonth(month);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: days.map((day) {
          bool isSelected = DateUtils.isSameDay(date, day);

          return GestureDetector(
            onTap: () {
              onDateChange(day);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:
                    isSelected ? AppColors.accentYellow : AppColors.almostWhite,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2,
                children: [
                  // Day number
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: GoogleFonts.instrumentSans(
                      fontWeight: FontWeight.w700,
                      color: isSelected ? Colors.white : AppColors.deepBlue,
                    ),
                    child: Text('${day.day}'),
                  ),
                  // Weekday name (Mon, Tue, etc.)
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: GoogleFonts.instrumentSans(
                      fontSize: 12,
                      color: isSelected ? Colors.white : AppColors.grey,
                    ),
                    child: Text(DateFormat.E().format(day)),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthYearLabel = DateFormat('MMMM yyyy').format(date);

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 24,
      children: [
        // -----------------------
        // Header: Month, Arrows, Calendar Icon
        // -----------------------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            spacing: 8,
            children: [
              const SizedBox(width: 1),
              Material(
                color: AppColors.almostWhite,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () => _shiftMonth(-1),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 24,
                    height: 24,
                    padding: EdgeInsets.all(4),
                    child: SvgPicture.asset('assets/icons/arrow-left.svg'),
                  ),
                ),
              ),
              MyText(monthYearLabel, color: AppColors.deepBlue),
              Material(
                color: AppColors.almostWhite,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () => _shiftMonth(1),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 24,
                    height: 24,
                    padding: EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      'assets/icons/arrow-right.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.richBrown,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onExpandCalendar,
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: SvgPicture.asset('assets/icons/calendar.svg'),
                  ),
                ),
              ),
            ],
          ),
        ),

        // -----------------------
        // Animated row of days
        // -----------------------
        _buildDaysRow(date),
      ],
    );
  }
}
