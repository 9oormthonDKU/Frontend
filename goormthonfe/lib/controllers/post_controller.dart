// post_controller.dart
import '../../models/post_model.dart';

class PostController {
  Post post = Post(
    title: '오늘 가볍게 달리실 분!',
    content: '''
20대분들과 같이 뛰고 싶어요!
뒷풀이 따로 하지 않고, 정말 가볍게 달리고 가실 분 구합니다. 
서로 페이스 맞춰가며 달리려 합니다.
러닝 초보이신 분들 환영해요!
''',
    location: '단국대학교 죽전캠퍼스 대운동장',
    date: '9월 29일 (일) 오후 8:00',
    distance: '5km',
    pace: '6:30',
  );

  void toggleLike() {
    post.isLiked = !post.isLiked;
    post.isLiked ? post.interest++ : post.interest--;
  }
}
