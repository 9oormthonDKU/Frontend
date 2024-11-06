// lib/models/sign_up_model.dart
class SignUpModel {
  String name = '';
  String gender = '';
  String birthDate = '';
  String username = '';
  String password = '';
  String confirmPassword = '';

  bool isPasswordMatch() {
    return password == confirmPassword;
  }
}
