// lib/views/applied_running_model.dart

class User {
  final String userId;
  final String userName;

  User({
    required this.userId,
    required this.userName,
  });
}

class RunningSession {
  final String time;
  final String description;
  final User createdBy;  // 러닝 세션을 만든 사용자
  final bool isCreatedByUser;  // 사용자가 만든 세션인지 여부

  RunningSession({
    required this.time,
    required this.description,
    required this.createdBy,
    this.isCreatedByUser = false,
  });
}

class CalendarModel {
  DateTime selectedDate;

  CalendarModel(this.selectedDate);
}
