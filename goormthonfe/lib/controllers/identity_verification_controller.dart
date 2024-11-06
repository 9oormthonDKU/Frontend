// lib/controllers/identity_verification_controller.dart
import '../models/identity_verification_model.dart';

class IdentityVerificationController {
  final IdentityVerificationModel _verificationModel;

  IdentityVerificationController(this._verificationModel);

  // 신원 정보 업데이트
  void updateName(String name) {
    _verificationModel.name = name;
  }

  void updateIdNumber(String idNumber) {
    _verificationModel.idNumber = idNumber;
  }

  // 신원 확인 완료 처리
  void verify() {
    _verificationModel.verifyIdentity();
  }

  bool isVerified() {
    return _verificationModel.isVerified;
  }
}
