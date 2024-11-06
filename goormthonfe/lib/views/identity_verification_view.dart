import 'package:flutter/material.dart';
import '../controllers/identity_verification_controller.dart';
import '../models/identity_verification_model.dart';
import 'id_card_camera_view.dart'; // 신분증 촬영 페이지 임포트

class IdentityVerificationView extends StatefulWidget {
  const IdentityVerificationView({Key? key}) : super(key: key);

  @override
  _IdentityVerificationViewState createState() => _IdentityVerificationViewState();
}

class _IdentityVerificationViewState extends State<IdentityVerificationView> {
  final IdentityVerificationModel _verificationModel = IdentityVerificationModel();
  late IdentityVerificationController _verificationController;

  @override
  void initState() {
    super.initState();
    _verificationController = IdentityVerificationController(_verificationModel);
  }

  Widget buildNumberCircle(String number) {
    return Container(
      width: 20,  // Adjusted to make the circle smaller
      height: 20,
      decoration: const BoxDecoration(
        color: Colors.grey,  // Changed the color to gray
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,  // Adjusted font size to fit the smaller circle
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '신분증 촬영',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Consistent horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),  // Adds space after appBar
            const Text(
              '신원확인을 위한 신분증 촬영입니다.\n실물 신분증을 준비해주세요.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.5), // 행간을 넓게 설정
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              '다음 화면에서 촬영을 진행합니다.',
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5), // 행간을 넓게 설정
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity, // Takes full width within the padding
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black38),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '주 민 등 록 증',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '김단국\n000000-000000',
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '2000.00.00',
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                        Text(
                          '서울특별시 경찰청장',
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey[200], // Placeholder background color
                      ),
                      child: const Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns number and text vertically
              children: [
                buildNumberCircle('1'),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    '신분증의 앞면이 보이도록 놓아주세요.\n   (어두운 바닥에 놓으면 더 잘 인식됩니다.)',
                    style: TextStyle(fontSize: 14, height: 2.5), // 행간을 넓게 설정
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),  // 숫자 1과 2 사이 간격 추가
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,  // Aligns number and text vertically
              children: [
                buildNumberCircle('2'),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    '가이드 영역에 맞추어 신분증 원본으로 촬영하세요.\n   (빛 반사에 주의하세요.)',
                    style: TextStyle(fontSize: 14, height: 2.5), // 행간을 넓게 설정
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),  // 숫자 2와 3 사이 간격 추가
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,  // Aligns number and text vertically
              children: [
                buildNumberCircle('3'),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    '운전면허증, 복사본 등은 정보 확인이 어렵거나 유효하지 않은 신분증일 경우 등록이 제한될 수 있습니다.',
                    style: TextStyle(fontSize: 14, height: 2.5), // 행간을 넓게 설정
                  ),
                ),
              ],
            ),
            const Spacer(),  // Pushes the button to the bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // Adds consistent padding below the button
              child: ElevatedButton(
                onPressed: () {
                  // 신분증 촬영 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IDCardCameraView()),  // IDCardCameraView로 이동
                  );
                },
                child: const Text('촬영하기', style: TextStyle(color: Colors.white)),  // 글자색을 흰색으로 설정
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),  // 버튼 크기 설정
                  backgroundColor: const Color(0xFF167DF9),  // 버튼 배경색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),  // 모서리를 둥글게 설정
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
