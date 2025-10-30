import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/data_source/data_source_impl.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/model/time_model.dart';
import 'package:up_todo_app/feature/home_screen/foucs/%20data/repo/repo_impl.dart';
import 'package:up_todo_app/feature/home_screen/foucs/domain/use_case/timer_use_case.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, TimerModel?>((ref) {
  final useCase = TimerUseCase(TimerRepoImpl(TimerDSImpl()));
  return TimerNotifier(useCase);
});

class TimerNotifier extends StateNotifier<TimerModel?> {
  final TimerUseCase useCase;
  Timer? _timer;

  TimerNotifier(this.useCase) : super(null) {
    loadSavedTime();
  }

  void startTimer(int min, int sec) {
    /*
// بجيب توتال الوقت عن طريق جمع الدقايق والثوانى مع بعض وتخزينهم كثوانى ف متغير
final totalTime=min*60+sec;
               نحول الدقايق لثوانى
//نخزنهم ف ال state عن طريق مساوتها ب  TimerModel Constructor
state=TimerModel(totalTime:totalTime,isRunning:true,remainingTime:totalTime,
startTime:DateTime.now());
//عايزين نطرح قيمة ال الوقت كل ثانية عن طريق Timer.periodic
_timer= Timer.periodic(Duration(seconds: 1),(timer)async{
final rem=state.remainingTime-1;
if(rem>=0){
timer.cancel();
state=sate!.copyWith(remainingTime:0,isRunning: false);
   }}
   else{
   state=state!.copyWith(remainingTime:rem,isRunning: true);
   await useCase.saveTime(state!);
   }
 */
    //===============================================================
    final total = min * 60 + sec;
    state = TimerModel(
      totalTime: total,
      isRunning: true,
      remainingTime: total,
      startTime: DateTime.now(),
    );
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      final remaining = state!.remainingTime - 1;
      if (remaining <= 0) {
        timer.cancel();
        state = state!.copyWith(remainingTime: 0, isRunning: false);
      } else {
        state = state!.copyWith(remainingTime: remaining, isRunning: true);
        await useCase.saveTimer(state!);
      }
    });
  }

  void stopTimer() async {
    _timer?.cancel();
    state = state?.copyWith(isRunning: false);
    if (state != null) await useCase.saveTimer(state!);
  }

  Future<void> loadSavedTime() async {
    /*
    // 1-هنجيب الوقت اللى كان محفوظ
     final saved=useCase.getTime();
     if(saved!=null){
     //هنجيب فرق الوقت من ساعة ما المستخدم خرج من التطبيق لحد دلوقتى
     final diff=DateTime.now().difference(saved.startTime!) .inSeconds;
     //بنطرح المتبقى من الوقت اللى كان اليوزر سايبه
     final rem=saved.remainingTime-diff;
     if (remaining > 0 && saved.isRunning) {
        startTimer(0, remaining);
      }
     }
     */
    final saved = useCase.getTimer();
    if (saved != null) {
      final diff = DateTime.now().difference(saved.startTime!).inSeconds;
      final remaining = saved.remainingTime - diff;
      if (remaining > 0 && saved.isRunning) {
        state = saved;
        resumeTimer(remaining);
      } else {
        state = saved.copyWith(isRunning: false, remainingTime: 0);
      }
    }
  }

  void resumeTimer(int remaining) {
    //الفانكشن دى عبارة عن ان الوقت لسه شغال فبنساوى الحالة بالوقت الموجود وبنطرح منه
    state = state!.copyWith(isRunning: true, remainingTime: remaining);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      final rem = state!.remainingTime - 1;
      if (rem <= 0) {
        timer.cancel();
        state = state!.copyWith(isRunning: false, remainingTime: 0);
        await useCase.clearTimer();
      } else {
        state = state!.copyWith(isRunning: true, remainingTime: rem);
        await useCase.saveTimer(state!);
      }
    });
  }
}
