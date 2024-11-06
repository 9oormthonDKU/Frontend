// lib/views/applied_running_controller.dart

import '../models/applied_running_model.dart';

class AppliedRunningController {
  List<RunningSession> getAppliedSessions() {
    // 신청한 러닝 세션 데이터를 가져오거나 목업 데이터를 반환
    return [
      RunningSession(
        time: "오전 7:30",
        description: "아침에 가볍게 달려요~~",
        createdBy: User(userId: "1", userName: "홍길동"),
      ),
      RunningSession(
        time: "오후 8:00",
        description: "오늘 가볍게 달리실 분!",
        createdBy: User(userId: "2", userName: "김철수"),
      ),
    ];
  }

  List<RunningSession> getCreatedSessions() {
    // 내가 만든 러닝 세션 데이터를 가져오거나 목업 데이터를 반환
    return [
      RunningSession(
        time: "오후 8:00",
        description: "오늘 가볍게 달리실 분!",
        createdBy: User(userId: "1", userName: "홍길동"),
        isCreatedByUser: true,
      ),
    ];
  }

  CalendarModel getCurrentDate() {
    return CalendarModel(DateTime.now());
  }
}
