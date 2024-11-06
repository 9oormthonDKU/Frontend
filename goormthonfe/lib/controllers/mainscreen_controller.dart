import '../models/mainscreen_model.dart';

class RunController {
  List<Run> getRuns() {
    return [
      Run(title: '오늘 저녁에 가볍게 뛰실 분들 모집합니다 !', location: '죽전', date: ''),
      Run(title: '퇴근하고 뛰실 분들 구해요 !', location: '죽전', date: ''),
      Run(title: '아침 러닝 하실 분 구합니다!', location: '수지', date: ''),
      Run(title: '점심시간에 가볍게 뛰실 분', location: '성남', date: ''),
      Run(title: '주말에 함께 러닝하실 분 모집', location: '기흥', date: ''),
    ];
  }

  List<Run> getPopularRuns() {
    return [
      Run(title: '오늘 가볍게 달리실 분 !', location: '죽전', date: '2024년 10월 5일(토) 오후 8:00'),
      Run(title: '10km 러닝 같이해요', location: '풍덕천', date: '2024년 9월 29일(일) 오후 8:00'),
      Run(title: '주말 산책 러닝', location: '광교', date: '2024년 10월 6일(일) 오전 10:00'),
      Run(title: '초보 러너 환영합니다!', location: '수원', date: '2024년 10월 7일(월) 오후 6:00'),
      Run(title: '강변에서 5km 가볍게', location: '양재천', date: '2024년 10월 8일(화) 오후 7:00'),
    ];
  }
}
