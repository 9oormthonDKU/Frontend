// lib/models/profile_controller.dart

class ProfileModel {
  String name;
  String age;
  String job;
  String gender;
  DateTime birthDate;
  String verificationStatus;
  String goal;
  String location;

  ProfileModel({
    required this.name,
    required this.age,
    required this.job,
    required this.gender,
    required this.birthDate,
    required this.verificationStatus,
    required this.goal,
    required this.location,
  });
}
