import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';
import 'package:up_todo_app/feature/home_screen/calender/widgets/card_date_item.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/view/widget/task_item.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class CalenderScreen extends ConsumerStatefulWidget {
  const CalenderScreen({super.key});

  @override
  ConsumerState<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends ConsumerState<CalenderScreen>
    with TickerProviderStateMixin {
  late DateTime currentMonth = DateTime.now();
  late List<DateTime> days;
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // currentMonth=DateTime.now();
    _generateDaysForMonth(currentMonth);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  void _generateDaysForMonth(DateTime month) {
    final nextMonth = DateTime(month.year, month.month + 1, 1);
    final lastDayOfMonth = nextMonth.subtract(Duration(days: 1));
    days = List.generate(lastDayOfMonth.day, (index) {
      return DateTime(month.year, month.month, index + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskViewModelProvider);
    final Complete = taskState.where((element) {
      return element.isComplete == true;
    }).toList();
    final selectedTab = ref.watch(selectedTabProvider);
    final now = DateTime.now();
    final nameMonth = DateFormat("MMMM").format(currentMonth);

    final year = DateFormat("yyyy").format(currentMonth);

    final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    final lastDayOfMonth = nextMonth.subtract(const Duration(days: 1));

    final days = List.generate(
      lastDayOfMonth.day,
      (index) => DateTime(currentMonth.year, currentMonth.month, index + 1),
    );

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: goToPriviousMonth,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              nameMonth.toUpperCase(),
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              year,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: goToNextMonth,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 58,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final dayName = DateFormat("E").format(days[index]);

                          final tody = DateTime.now();
                          final isToday =
                              days[index].day == tody.day &&
                              days[index].month == tody.month &&
                              days[index].year == tody.year;
                          final isWeekend =
                              dayName == "SAT" || dayName == "SUN";
                          return CardDateItem(
                            isWeekend: isWeekend,
                            isSelected: isToday,
                            nameOfTheDay: dayName,
                            numOfTheDay: days[index].day,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 14);
                        },
                        itemCount: days.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.all(6),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color(0xff4C4C4C),
            ),
            child: Row(
              spacing: 32,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(selectedTabProvider.notifier).state = 0;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTab == 0
                          ? Color(0xff8685E7)
                          : Colors.grey[800],
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: selectedTab != 0
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      "All Tasks",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(selectedTabProvider.notifier).state = 1;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTab == 1
                          ? Color(0xff8685E7)
                          : Colors.grey[800],
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: selectedTab != 1
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      "Completed",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16, right: 24, left: 24),
              itemBuilder: (context, index) {
                final list = selectedTab == 0 ? taskState : Complete;
                final task = list[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PageRouteName.editScreen,
                      arguments: task,
                    );
                  },
                  child: TaskItem(model: task),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16);
              },
              itemCount: selectedTab == 0 ? taskState.length : Complete.length,
            ),
          ),
        ],
      ),
    );
  }

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
}
