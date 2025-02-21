import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class CustomDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChange;

  const CustomDatePicker({super.key, required this.onDateChange});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime currentDate = DateTime.now();
  double _opacity = 1.0; // Controls smooth fading

  /// Changes the displayed month with a smooth transition
  void _changeMonth(int direction) async {
    setState(() {
      _opacity = 0.0; // Fade out first
    });

    await Future.delayed(Duration(milliseconds: 200)); // Wait for fade-out

    setState(() {
      int targetYear = currentDate.year;
      int targetMonth = currentDate.month + direction;

      if (targetMonth < 1) {
        targetYear -= 1;
        targetMonth = 12;
      } else if (targetMonth > 12) {
        targetYear += 1;
        targetMonth = 1;
      }

      int daysInTargetMonth = DateTime(targetYear, targetMonth + 1, 0).day;
      int newDay = currentDate.day > daysInTargetMonth
          ? daysInTargetMonth
          : currentDate.day;

      currentDate = DateTime(targetYear, targetMonth, newDay);
      _opacity = 1.0; // Fade in after state update
    });
  }

  /// Builds the calendar grid for the current month
  Widget _buildCalendar() {
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    int startingWeekday = firstDayOfMonth.weekday;
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;

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
              DateTime(currentDate.year, currentDate.month, dayCounter);
          bool isSelected = day.day == currentDate.day;

          weekRow.add(
            Expanded(
              child: Container(
                margin: EdgeInsets.all(3),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accentYellow
                        : Color.fromRGBO(249, 250, 251, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _selectDate(day),
                      borderRadius: BorderRadius.circular(8),
                      splashColor: AppColors.accentYellow.withOpacity(0.2),
                      highlightColor: AppColors.accentYellow.withOpacity(0.1),
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
                                    : AppColors.deepBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              child: Text('${day.day}'),
                            ),
                            SizedBox(height: 2),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : Color.fromRGBO(255, 129, 66, 1),
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
    return Column(
      children: [
        // Month & Navigation Row
        Row(
          spacing: 10,
          children: [
            Material(
              color: AppColors.lightGrey,
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
                      Color.fromRGBO(107, 114, 128, 1),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            MyText.deepBlue(
              DateFormat('MMMM yyyy').format(currentDate),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            Material(
              color: AppColors.lightGrey,
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
                      Color.fromRGBO(107, 114, 128, 1),
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
          children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
              .map(
                (day) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MyText(
                    day,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(107, 114, 128, 1),
                  ),
                ),
              )
              .toList(),
        ),

        // Calendar Grid
        _buildCalendar(),
      ],
    );
  }

  /// Selects a new date and calls `onDateChange`
  void _selectDate(DateTime date) {
    setState(() {
      currentDate = date;
    });

    widget.onDateChange(date);
  }
}
