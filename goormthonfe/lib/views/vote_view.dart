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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('나의 러닝'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.75,
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
                  controller.resetVote(index);
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

  UserVoteCard({
    required this.user,
    required this.onAccept,
    required this.onDecline,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    bool isPending = user.status == 'pending';
    bool isAccepted = user.status == 'accepted';
    bool isDeclined = user.status == 'declined';

    Color cardColor = Colors.white;
    String statusText = '';
    if (isAccepted) {
      cardColor = Color(0xFFE9F3FF); // 수락 완료 배경색
      statusText = '수락 완료';
    } else if (isDeclined) {
      cardColor = Color(0xFFF2F2F2); // 거절 완료 배경색
      statusText = '거절 완료';
    }

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isPending ? Colors.grey : Colors.transparent,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey),
              ],
            ),
            SizedBox(height: 4),
            Text(
              '${user.age} ${user.job}',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              '신원 인증 완료',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Spacer(),
            if (isPending) ...[
              ElevatedButton(
                onPressed: onAccept,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Center(child: Text('함께 달리기', style: TextStyle(fontSize: 14))),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF167DF9)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
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
                  height: 48,
                  child: Center(child: Text('거절하기', style: TextStyle(fontSize: 14))),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFF2F2F2)),
                  foregroundColor: MaterialStateProperty.all(Color(0xFF787878)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  side: MaterialStateProperty.all(BorderSide(color: Colors.grey)),
                ),
              ),
            ] else if (isAccepted || isDeclined) ...[
              ElevatedButton(
                onPressed: null,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Center(child: Text(statusText, style: TextStyle(fontSize: 14))),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      isAccepted ? Color(0xFFB0C4FF) : Color(0xFFD3D3D3)), // 버튼 색상 맞춤
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: onChange,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Center(child: Text('변경하기', style: TextStyle(fontSize: 14))),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Color(0xFF787878)),
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