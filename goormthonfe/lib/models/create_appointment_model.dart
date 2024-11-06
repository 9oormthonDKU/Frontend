
class Appointment {
  String title;
  String details;
  String location;
  DateTime date;
  String timeSlot;
  int distance;
  int pace;
  String participants;

  Appointment({
    required this.title,
    required this.details,
    required this.location,
    required this.date,
    required this.timeSlot,
    required this.distance,
    required this.pace,
    required this.participants,
  });
}
