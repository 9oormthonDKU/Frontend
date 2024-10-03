// lib/views/identity_verification_view.dart
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: AppBar(
        title: const Text('신분증 촬영'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '신원확인을 위한 신분증 촬영입니다.\n실물 신분증을 준비해주세요.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                '다음 화면에서 촬영을 진행합니다.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Card(
                elevation: 2,
                child: SizedBox(
                  width: 300,
                  height: 180,
                  child: Center(
                    child: Text(
                      '주 민 등 록 증\n김단국\n000000-000000',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '1. 신분증의 앞면이 보이도록 놓아주세요.\n   (어두운 바닥에 놓으면 더 잘 인식됩니다.)',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '2. 가이드 영역에 맞추어 신분증 원본으로 촬영하세요.\n   (빛 반사에 주의하세요.)',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '3. 운전면허증, 복사본 등은 정보 확인이 어렵거나 유효하지 않은 신분증일 경우 등록이 제한될 수 있습니다.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
