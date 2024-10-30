// post_view.dart
import 'package:flutter/material.dart';
import '../../controllers/post_controller.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostController controller = PostController();
  bool isParticipating = false;
  int currentParticipants = 6; // 현재 참가자 수
  final int maxParticipants = 10; // 최대 참가자 수

  @override
  Widget build(BuildContext context) {
    // 참가 비율 계산 (현재 참가자 / 최대 참가자)
    double participationRatio = currentParticipants / maxParticipants;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.post.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/dankook_university.png', // assets 폴더 내의 이미지 경로
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 18),
            // 신청 현황 부분 (텍스트 고정)
            Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: (participationRatio * 100).toInt(),
                      child: Container(
                        height: 30, // 신청 현황 바의 높이를 줄임
                        decoration: BoxDecoration(
                          color: Color(0xFF167DF9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: ((1 - participationRatio) * 100).toInt(),
                      child: Container(
                        height: 30, // 신청 현황 바의 높이를 줄임
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '       현재 ${currentParticipants}명이 같이 달리려 하고 있어요!',
                          style: TextStyle(
                            color: Colors.white, // 현재 인원 텍스트 색상 유지
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.left, // 왼쪽 정렬
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '제한인원 ${maxParticipants}명',
                          style: TextStyle(
                            color: Colors.grey[700], // 제한 인원 텍스트 어두운 색으로 설정
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.right, // 오른쪽 정렬
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(controller.post.content),
            Divider(color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '${controller.post.location}\n${controller.post.date}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('${controller.post.distance} | ${controller.post.pace}'),
            Divider(color: Colors.grey),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('관심 ${controller.post.interest} 조회 ${controller.post.views} 신고하기'),
                IconButton(
                  icon: Icon(
                    controller.post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: controller.post.isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      controller.toggleLike();
                    });
                  },
                ),
              ],
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 8),
            Text("김단국"),
            Divider(color: Colors.grey),
            Spacer(), // 화면 하단에 버튼을 고정
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (!isParticipating) {
                      if (currentParticipants < maxParticipants) {
                        currentParticipants++;
                        isParticipating = true;
                      }
                    } else {
                      currentParticipants--;
                      isParticipating = false;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isParticipating ? Colors.white : Color(0xFF167DF9), // 참여하기 색상 설정
                  side: BorderSide(
                    color: Color(0xFF167DF9),
                  ),
                  minimumSize: Size(double.infinity, 60), // 높이를 60으로 설정
                ),
                child: Text(
                  isParticipating ? "취소하기" : "참여하기",
                  style: TextStyle(
                    color: isParticipating ? Color(0xFF167DF9) : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
