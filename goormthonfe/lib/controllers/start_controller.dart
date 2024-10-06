// lib/controllers/start_controller.dart

import '../models/start_model.dart';

class StartController {
  final StartModel startModel;

  StartController(this.startModel);

  String get goal => startModel.goal;
  String get location => startModel.location;

  void updateGoal(String newGoal) {
    startModel.goal = newGoal;
  }

  void updateLocation(String newLocation) {
    startModel.location = newLocation;
  }
}
