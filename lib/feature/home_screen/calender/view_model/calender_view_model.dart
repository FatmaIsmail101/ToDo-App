import 'package:flutter_riverpod/legacy.dart';

final calenderProvider = StateNotifierProvider<CalenderNotifier, CalenderState>(
  (ref) => CalenderNotifier(),
);

class CalenderState {
  final DateTime currentDate;
  final List<DateTime> days;

  CalenderState({required this.currentDate, required this.days});

  CalenderState copyWith({DateTime? currentDate, List<DateTime>? days}) {
    return CalenderState(
      currentDate: currentDate ?? this.currentDate,
      days: days ?? this.days,
    );
  }
}

class CalenderNotifier extends StateNotifier<CalenderState> {
  CalenderNotifier()
    : super(
        CalenderState(
          currentDate: DateTime.now(),
          days: _generateDaysForMonth(DateTime.now()),
        ),
      );

  static List<DateTime> _generateDaysForMonth(DateTime date) {
    //جبنا أول يوم ف الشهر اللى بعد اللى واقفين فيه
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    //حبنا اخر يوم ف الشهر اللى واقفين فيه
    final lastDay = nextMonth.subtract(Duration(days: 1));
    return List.generate(lastDay.day, (index) {
      return DateTime(date.year, date.month, index + 1);
    });
  }

  void goToPreviousMonth() {
    final prev = DateTime(state.currentDate.year, state.currentDate.month - 1);
    state = CalenderState(currentDate: prev, days: _generateDaysForMonth(prev));
  }

  void goToNextMonth() {
    final next = DateTime(state.currentDate.year, state.currentDate.month + 1);
    state = CalenderState(currentDate: next, days: _generateDaysForMonth(next));
  }
}
