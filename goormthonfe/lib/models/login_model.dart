// lib/models/login_model.dart
class LoginModel {
  String username = '';
  String password = '';

  // 간단한 유효성 검사
  bool isValid() {
    return username.isNotEmpty && password.isNotEmpty;
  }
}
