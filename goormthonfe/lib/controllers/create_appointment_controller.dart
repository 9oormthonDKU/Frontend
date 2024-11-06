class CreateAppointmentController {
  String? title;
  String? details;
  String? location;
  int? distance;
  int? pace;
  DateTime? date;
  String? timeSlot;
  bool isParticipantsUnlimited = true; // 인원 무관 기본값
  int? participantsLimit;

  void setDistance(int distance) {
    this.distance = distance;
  }

  void setPace(int pace) {
    this.pace = pace;
  }

  void setDate(DateTime date) {
    this.date = date;
  }

  void setTimeSlot(String timeSlot) {
    this.timeSlot = timeSlot;
  }

  // 인원 무관 설정
  void setParticipantsUnlimited() {
    isParticipantsUnlimited = true;
    participantsLimit = null; // 인원 무관이면 제한 인원 없음
  }

  // 인원 제한 설정
  void setParticipantsLimited(int limit) {
    isParticipantsUnlimited = false;
    participantsLimit = limit; // 제한 인원 설정
  }

  // participantsUnlimited getter 추가
  bool get participantsUnlimited => isParticipantsUnlimited;
}