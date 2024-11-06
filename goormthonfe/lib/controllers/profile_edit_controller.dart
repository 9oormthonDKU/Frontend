import '../models/profile_edit_model.dart';

class ProfileEditController {
  final ProfileEditModel profileEditModel;

  ProfileEditController(this.profileEditModel);

  void updateName(String name) {
    profileEditModel.name = name;
  }

  void updateGender(String gender) {
    profileEditModel.gender = gender;
  }

  void updateBirthDate(DateTime birthDate) {
    profileEditModel.birthDate = birthDate;
  }

  void updateGoal(String goal) {
    profileEditModel.goal = goal;
  }

  void updateLocation(String location) {
    profileEditModel.location = location;
  }
}
