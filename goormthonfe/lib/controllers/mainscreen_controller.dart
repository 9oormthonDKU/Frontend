import '../models/mainscreen_model.dart';

class RunController {
  List<Run> getRuns() {
    return [
      Run(title: '오늘 저녁에 가볍게 뛰실 분들 모집합니다 !', location: '죽전', date:''),
      Run(title: '퇴근하고 뛰실 분들 구해요 !', location: '죽전', date:''),
    ];
  }

  List<Run> getPopularRuns() {
    return [
      Run(title: '오늘 가볍게 달리실 분 !', location: '죽전', date:'2024년 10월 5일(토) 오후 8:00'),
      Run(title: '10km 러닝 같이해요', location: '풍덕천', date:'2024년 9월 29일(일) 오후 8:00'),
    ];
  }
}
