import 'package:flutter/material.dart';
import 'sign_up_view.dart';  // 회원가입 화면을 임포트
import '../controllers/login_controller.dart';
import '../models/login_model.dart';
import 'mainscreen_view.dart';  // MainScreen 페이지 임포트 추가

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginModel _loginModel = LoginModel();
  late LoginController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = LoginController(_loginModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 그라데이션이 중간까지만 적용되는 부분
          Container(
            height: MediaQuery.of(context).size.height * 0.5,  // 화면의 절반까지
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF167DF9),  // 상단 색상 (167DF9 하늘색)
                  Color(0xFFFFFFFF),  // 중간 색상 (흰색)
                ],
                stops: [0.0, 1.0],  // 그라데이션이 중간까지만 적용
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/login_image.png',  // 이미지 파일
                height: 200,
              ),
            ),
          ),
          // 그라데이션 아래의 텍스트 및 입력 필드를 흰색 배경으로 감싸기
          Expanded(
            child: Container(
              color: Colors.white,  // 배경색을 흰색으로 설정
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // 수평 여백
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // 위쪽으로 정렬
                  children: [
                    const SizedBox(height: 10), // 조금 더 위로 올리기 위한 여백
                    const Text(
                      '우리 함께\n런닝 할 사람 구해요!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10), // 기존 20에서 줄임
                    TextField(
                      decoration: InputDecoration(
                        labelText: '아이디',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),  // 입력 필드 배경색
                      ),
                      onChanged: (value) {
                        _loginController.updateUsername(value);
                      },
                    ),
                    const SizedBox(height: 8), // 기존 10에서 줄임
                    TextField(
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),  // 입력 필드 배경색
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        _loginController.updatePassword(value);
                      },
                    ),
                    const SizedBox(height: 15), // 기존 20에서 줄임
                    ElevatedButton(
                      onPressed: () {
                        if (_loginController.login()) {
                          // 로그인 성공 시 MainScreen으로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('아이디와 비밀번호를 확인하세요')),
                          );
                        }
                      },
                      child: const Text('로그인하기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF167DF9),  // 기존 primary 대신 backgroundColor 사용
                        foregroundColor: Colors.white,  // 기존 onPrimary 대신 foregroundColor 사용
                        minimumSize: const Size(double.infinity, 50),  // 버튼을 전체 너비로 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),  // 버튼의 모서리를 둥글게
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // 여백을 유지
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // 회원가입 화면으로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpView()),
                            );
                          },
                          child: const Text(
                            '회원가입',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const Text(
                          '|',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            // 계정찾기 로직
                          },
                          child: const Text(
                            '계정찾기',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
