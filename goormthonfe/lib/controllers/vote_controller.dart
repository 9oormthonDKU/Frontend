import 'package:flutter/material.dart';
import '../../models/vote_model.dart';

class VoteController extends ChangeNotifier {
  List<UserVoteModel> users = [
    UserVoteModel(name: '최상경', age: '23세', job: '바리스타', status: 'pending'),
    UserVoteModel(name: '김준현', age: '32세', job: '자영업', status: 'pending'),
    // 추가 사용자
    UserVoteModel(name: '김민지', age: '22세', job: '대학생', status: 'pending'),
    UserVoteModel(name: '강호준', age: '28세', job: '회사원', status: 'pending'),
    UserVoteModel(name: '최예원', age: '23세', job: '회사원', status: 'pending'),
    UserVoteModel(name: '권진호', age: '23세', job: '대학생', status: 'pending'),
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
