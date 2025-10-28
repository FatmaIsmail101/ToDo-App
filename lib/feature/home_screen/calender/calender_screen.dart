import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/calender/view_model/calender_view_model.dart';
import 'package:up_todo_app/feature/home_screen/calender/widgets/calender_header.dart';
import 'package:up_todo_app/feature/home_screen/calender/widgets/days_list.dart';
import 'package:up_todo_app/feature/home_screen/calender/widgets/list_task.dart';
import 'package:up_todo_app/feature/home_screen/calender/widgets/task_tabs.dart';

final selecteDayProvider = StateProvider<DateTime?>((ref) => null);

class CalenderScreen extends ConsumerStatefulWidget {
  const CalenderScreen({super.key});

  @override
  ConsumerState<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends ConsumerState<CalenderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final calender = ref.watch(calenderProvider);

    return SafeArea(
      child: Column(
        spacing: 20,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24.0, right: 24, left: 24),
            child: Text(
              "Calendar",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                color: Color(0xf2202020),
                child: Column(
                  children: <Widget>[
                    CalenderHeader(
                      currentDate: calender.currentDate,
                      goToNext: ref
                          .read(calenderProvider.notifier)
                          .goToNextMonth,
                      goToPrev: ref
                          .read(calenderProvider.notifier)
                          .goToPreviousMonth,
                    ),
                    DaysList(
                      days: calender.days,
                      onDaySelected: (day) {
                        ref.read(selecteDayProvider.notifier).state = day;
                      },
                      selectedDay: ref.watch(selecteDayProvider),
                    ),
                  ],
                ),
              ),
            ],
          ),
          TaskTabs(),
          ListTask(),
        ],
      ),
    );
  }
}

/*
  void goToPriviousMonth() {
    final now = DateTime.now();

    ///اليوم الحالى

    final firstDayOfCurrentMonth =
        ///اليوم الاول ف الشهر الحالى
        DateTime(now.year, now.month, 1);
    final lastDayOfPrevMonth =
        ///أخر يوم ف الشهر اللى قبله عشان نعرف عدد أيامه
        firstDayOfCurrentMonth.subtract(Duration(days: 1));
    final daysInPrevMonth = lastDayOfPrevMonth.day;

    ///
    ///عدد أيام الشهر اللى قبله
    ///نعمل اوبجيكت يمثل الشهر اللى قبله
    final prevMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);

    ///أول يوم ف الشهر السابق

    final prevMonthDays = List.generate(daysInPrevMonth, (index) {
      return DateTime(prevMonth.year, prevMonth.month, index + 1);
    });
    setState(() {
      currentMonth = prevMonth;
      _generateDaysForMonth(currentMonth);
    });
  }

  void goToNextMonth() {
    //1- بنجيب أول يوم ف الشهر الجديد
    final firstDayOfNextMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      1,
    );

    ///نجيب آخر يوم فى الشهر الجديد
    final firstDayOfMonthAfter = DateTime(
      currentMonth.year,
      currentMonth.month + 2,
      1,
    );

    ///نطرح من أول يوم ف الشهر اللى بعد اللى عايزينه يوم عشان يطلعلنا اخر يوم فى الشهر اللى عايزينه
    final lastDayOfNextMonth = firstDayOfMonthAfter.subtract(Duration(days: 1));

    ///نرجع اخر يوم ف الشهر اللى عايزينه
    final daysInNextMonth = lastDayOfNextMonth.day;

    ///5- ليستة الايام
    final nextMonthDays = List.generate(daysInNextMonth, (index) {
      return DateTime(
        firstDayOfMonthAfter.year,
        firstDayOfMonthAfter.month,
        index + 1,
      );
    });
    setState(() {
      currentMonth = firstDayOfNextMonth;
      days = nextMonthDays;
    });
  }
 */
