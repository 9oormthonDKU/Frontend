import 'package:flutter/material.dart';
import '../../models/vote_model.dart';

class VoteController extends ChangeNotifier {
  List<UserVoteModel> users = [
    UserVoteModel(name: '최상경', age: '23세', job: '바리스타', status: 'pending'),
    UserVoteModel(name: '김준현', age: '32세', job: '자영업', status: 'pending'),
    // 추가 사용자
  ];

  void acceptVote(int index) {
    users[index].status = 'accepted';
    notifyListeners();
  }

  void declineVote(int index) {
    users[index].status = 'declined';
    notifyListeners();
  }

  // resetVote 메서드 추가
  void resetVote(int index) {
    users[index].status = 'pending';
    notifyListeners();
  }
}
