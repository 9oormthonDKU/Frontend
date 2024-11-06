// lib/controllers/sign_up_controller.dart
import '../models/sign_up_model.dart';

class SignUpController {
  final SignUpModel _signUpModel;

  SignUpController(this._signUpModel);

  void updateName(String name) {
    _signUpModel.name = name;
  }

  void updateGender(String gender) {
    _signUpModel.gender = gender;
  }

  void updateBirthDate(String birthDate) {
    _signUpModel.birthDate = birthDate;
  }

  void updateUsername(String username) {
    _signUpModel.username = username;
  }

  void updatePassword(String password) {
    _signUpModel.password = password;
  }

  void updateConfirmPassword(String confirmPassword) {
    _signUpModel.confirmPassword = confirmPassword;
  }

  bool isPasswordValid() {
    return _signUpModel.isPasswordMatch();
  }
}
