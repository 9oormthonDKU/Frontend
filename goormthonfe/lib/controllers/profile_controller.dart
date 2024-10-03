// lib/controllers/profile_controller.dart
import '../models/profile_model.dart';

class ProfileController {
  final ProfileModel _profileModel;

  ProfileController(this._profileModel);

  // 프로필 정보를 업데이트하는 메서드
  void updateProfile(String name, String age, String job) {
    _profileModel.name = name;
    _profileModel.age = age;
    _profileModel.job = job;
  }

// 기타 필요한 비즈니스 로직을 여기에 추가
}
