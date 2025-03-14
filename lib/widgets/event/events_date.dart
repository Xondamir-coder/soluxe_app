import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/providers/events_provider.dart';
import 'package:soluxe/widgets/date_pickers/collapsed_date_picker.dart';
import 'package:soluxe/widgets/date_pickers/expanded_date_picker.dart';
import 'package:soluxe/widgets/drag_handle.dart';

class EventsDate extends ConsumerStatefulWidget {
  const EventsDate({super.key});

  @override
  ConsumerState<EventsDate> createState() => _EventsDateState();
}

class _EventsDateState extends ConsumerState<EventsDate> {
  var isExpanded = false;

  void expandCalendar(bool direction) {
    setState(() {
      isExpanded = direction;
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventsDate = ref.watch(eventsDateProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onVerticalDragStart: (details) => expandCalendar(false),
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          expandCalendar(true);
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10, top: 16),
        decoration: BoxDecoration(
          color: AppColors.adaptiveDarkBlueOrWhite(isDark),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        child: Column(
          spacing: 16,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isExpanded
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ExpandedDatePicker(
                        key: const ValueKey('expanded'),
                        date: eventsDate,
                        onDateChange: (value) =>
                            ref.read(eventsDateProvider.notifier).state = value,
                        isMonthCentered: true,
                      ),
                    )
                  : CollapsedDatePicker(
                      key: const ValueKey('collapsed'),
                      date: eventsDate,
                      onDateChange: (value) =>
                          ref.read(eventsDateProvider.notifier).state = value,
                      onExpandCalendar: () => expandCalendar(true),
                    ),
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
            ),
            if (!isExpanded) const DragHandle(),
          ],
        ),
      ),
    );
  }
}
