// lib/controllers/login_controller.dart
import '../models/login_model.dart';

class LoginController {
  final LoginModel _loginModel;

  LoginController(this._loginModel);

  // Function to handle login button press
  bool login() {
    if (_loginModel.isValid()) {
      // Perform login logic, such as API call (example)
      return true;
    }
    return false;
  }

  // Update username and password in the model
  void updateUsername(String username) {
    _loginModel.username = username;
  }

  void updatePassword(String password) {
    _loginModel.password = password;
  }
}
