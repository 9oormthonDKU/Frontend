import 'dart:io';  // File 클래스를 사용하기 위한 import
import 'package:flutter/material.dart';
import '../controllers/id_card_camera_controller.dart';  // 컨트롤러 임포트
import 'start_view.dart'; // StartView import

class IDCardCameraView extends StatefulWidget {
  const IDCardCameraView({Key? key}) : super(key: key);

  @override
  _IDCardCameraViewState createState() => _IDCardCameraViewState();
}

class _IDCardCameraViewState extends State<IDCardCameraView> {
  late IDCardCameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = IDCardCameraController();  // 컨트롤러 인스턴스 생성
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],  // 배경을 어두운 회색으로 설정
      appBar: AppBar(
        title: const Text('신분증 촬영'),
        centerTitle: true,
        backgroundColor: Colors.black,  // AppBar 배경색을 검은색으로 설정
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),  // 아이콘 흰색 설정
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(  // 중앙 정렬을 위해 Center 위젯 사용
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // 수직 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center,  // 가로로도 중앙 정렬
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                '빛 반사가 생기지 않도록\n어두운 배경에서 촬영해주세요.',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 300,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 3),  // 흰색 테두리
              ),
              child: const Center(
                child: Icon(
                  Icons.credit_card,  // 신분증 가이드 아이콘
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 50),
            IconButton(
              iconSize: 80,
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () async {
                await _controller.takePicture();  // 컨트롤러에서 촬영 로직 호출

                // 사진 촬영 후 StartView로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StartView()),
                );
              },
            ),
            const SizedBox(height: 20),
            // 촬영된 사진이 있으면 화면에 표시
            if (_controller.getSelectedImage() != null)
              Image.file(
                _controller.getSelectedImage()!,
                height: 200,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }
}
