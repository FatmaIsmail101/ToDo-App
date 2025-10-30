class TimerModel {
  final int totalTime; //المدة الكاملة
  final int remainingTime; //الوقت المتبقى
  final bool isRunning; //التايمر شغال ولا لا
  final DateTime? startTime; //الوقت اللى بدأ فيه
  TimerModel({
    required this.totalTime,
    required this.isRunning,
    this.startTime,
    required this.remainingTime,
  });

  TimerModel copyWith({
    int? totalTime,
    bool? isRunning,
    DateTime? startTime,
    int? remainingTime,
  }) {
    return TimerModel(
      totalTime: totalTime ?? this.totalTime,
      isRunning: isRunning ?? this.isRunning,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }

  Map<String, dynamic> toJson() => {
    "totalTime": totalTime,
    "remainingTime": remainingTime,
    "isRunning": isRunning,
    "startTime": startTime?.toIso8601String(),
  };

  factory TimerModel.fromJson(Map<String, dynamic> json) => TimerModel(
    totalTime: (json["totalTime"] ?? 0) as int,
    isRunning: json["isRunning"] ?? false,
    remainingTime: (json["remainingTime"] ?? 0) as int,
    startTime: json["startTime"] != null
        ? DateTime.parse(json["startTime"])
        : DateTime.now(),
  );
}
