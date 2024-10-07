import 'package:flutter/material.dart';
import '../controllers/start_controller.dart';
import '../models/start_model.dart';
import 'mainscreen_view.dart'; // MainScreen 페이지 import

class StartView extends StatefulWidget {
  @override
  _StartViewState createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  late StartController _startController;
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 초기 값 설정
    StartModel startModel = StartModel(goal: '12km', location: '경기도 용인시 수지구 전체');
    _startController = StartController(startModel);

    // 초기 입력값 설정
    _goalController.text = _startController.goal;
    _locationController.text = _startController.location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 흰색
      appBar: AppBar(
        title: const Text('시작하기'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 환영 메시지
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
                children: [
                  TextSpan(
                    text: '안녕하세요! ',
                    style: TextStyle(color: Colors.black), // 글씨 색상 검정
                  ),
                  TextSpan(
                    text: '김단국님.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // 글씨 색상 검정
                    ), // 이름을 굵게 표시
                  ),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: '진런이',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ), // 러닝앱을 파란색으로 강조
                  ),
                  TextSpan(
                    text: '에 오신 것을 환영합니다!',
                    style: TextStyle(color: Colors.black), // 글씨 색상 검정
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 목표 러닝 입력란
            Text('목표 러닝 km를 알려주세요', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _goalController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 활동할 위치 입력란
            Text('활동할 위치를 알려주세요', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),

            // 시작하기 버튼
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // '시작하기' 버튼 눌렀을 때 MainScreen으로 이동
                  _startController.updateGoal(_goalController.text);
                  _startController.updateLocation(_locationController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()), // MainScreen 페이지로 이동
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('시작하기', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}