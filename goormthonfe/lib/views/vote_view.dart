import 'package:flutter/material.dart';
import '../../models/vote_model.dart';
import '../../controllers/vote_controller.dart';

class VoteScreen extends StatefulWidget {
  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  final VoteController controller = VoteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경을 흰색으로 설정
      appBar: AppBar(
        title: Text('나의 러닝'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // 앱바 텍스트 색상 변경
        elevation: 0, // 앱바 그림자 제거
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 가로로 2개의 아이템을 배치
            crossAxisSpacing: 8, // 아이템 간 가로 간격
            mainAxisSpacing: 8, // 아이템 간 세로 간격
            childAspectRatio: 1.1, // 세로 길이를 더 늘리기 위해 비율을 낮춤
          ),
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            return UserVoteCard(
              user: controller.users[index],
              onAccept: () {
                setState(() {
                  controller.acceptVote(index);
                });
              },
              onDecline: () {
                setState(() {
                  controller.declineVote(index);
                });
              },
              onChange: () {
                setState(() {
                  controller.resetVote(index); // 투표 상태 초기화 기능
                });
              },
            );
          },
        ),
      ),
    );
  }
}

class UserVoteCard extends StatelessWidget {
  final UserVoteModel user;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onChange;

  UserVoteCard({required this.user, required this.onAccept, required this.onDecline, required this.onChange});

  @override
  Widget build(BuildContext context) {
    bool isPending = user.status == 'pending';
    bool isCompleted = user.status == 'accepted' || user.status == 'declined';

    return Card(
      color: isPending ? Colors.white : Colors.grey[200], // 상태에 따라 배경색 변경
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isPending ? Colors.grey : Colors.transparent, // 상태에 따른 테두리 색상 설정
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${user.name}, ${user.age}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${user.job}', style: TextStyle(color: Colors.grey)),
            Spacer(), // 남은 공간을 채워 아래 버튼들이 하단에 위치하게 함
            if (isPending) ...[
              ElevatedButton(
                onPressed: onAccept,
                child: SizedBox(
                  width: double.infinity,
                  height: 48, // 버튼 높이 증가
                  child: Center(child: Text('함께 달리기')),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF167DF9)), // 배경색 #167DF9
                  foregroundColor: MaterialStateProperty.all(Colors.white), // 글씨 색 흰색
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: onDecline,
                child: SizedBox(
                  width: double.infinity,
                  height: 48, // 버튼 높이 증가
                  child: Center(child: Text('거절하기')),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFF2F2F2)), // 배경색 #F2F2F2
                  foregroundColor: MaterialStateProperty.all(Color(0xFF787878)), // 글씨 색 #787878
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  side: MaterialStateProperty.all(BorderSide(color: Colors.grey)),
                ),
              ),
            ] else if (isCompleted) ...[
              ElevatedButton(
                onPressed: null,
                child: SizedBox(
                  width: double.infinity,
                  height: 48, // 버튼 높이 증가
                  child: Center(child: Text(user.status == 'accepted' ? '수락 완료' : '거절 완료')),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: onChange,
                child: SizedBox(
                  width: double.infinity,
                  height: 48, // 버튼 높이 동일하게 설정
                  child: Center(child: Text('변경하기')),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white), // 흰색 배경
                  foregroundColor: MaterialStateProperty.all(Color(0xFF787878)), // 글씨 색 #787878
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  side: MaterialStateProperty.all(BorderSide(color: Colors.grey)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
