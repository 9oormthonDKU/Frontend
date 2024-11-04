class UserVoteModel {
  String name;
  String age;
  String job;
  String status; // 'pending', 'accepted', 'declined'

  UserVoteModel({required this.name, required this.age, required this.job, this.status = 'pending'});
}