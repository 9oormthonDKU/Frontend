// lib/models/identity_verification_model.dart
class IdentityVerificationModel {
  String idNumber = '';
  String name = '';
  bool isVerified = false;

  // 신원 확인 완료 후 상태 변경
  void verifyIdentity() {
    isVerified = true;
  }
}
