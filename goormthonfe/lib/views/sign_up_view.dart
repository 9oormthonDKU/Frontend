// lib/views/sign_up_view.dart
import 'package:flutter/material.dart';
import '../controllers/sign_up_controller.dart';
import '../models/sign_up_model.dart';
import 'identity_verification_view.dart';  // IdentityVerificationView 클래스를 임포트

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpModel _signUpModel = SignUpModel();
  late SignUpController _signUpController;

  @override
  void initState() {
    super.initState();
    _signUpController = SignUpController(_signUpModel);
  }

  String _selectedGender = '여성'; // 기본 성별 설정
  DateTime _selectedDate = DateTime(2000, 1, 1); // 기본 날짜 설정

  // 생년월일 선택하는 함수
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _signUpController.updateBirthDate(
          '${_selectedDate.year}.${_selectedDate.month}.${_selectedDate.day}',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('프로필 설정'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '이름',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _signUpController.updateName(value);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                '성별',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: '남성',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value!;
                        _signUpController.updateGender(_selectedGender);
                      });
                    },
                  ),
                  const Text('남성'),
                  Radio<String>(
                    value: '여성',
                    groupValue: _selectedGender,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value!;
                        _signUpController.updateGender(_selectedGender);
                      });
                    },
                  ),
                  const Text('여성'),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                '생년월일',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  labelText: '${_selectedDate.year}.${_selectedDate.month}.${_selectedDate.day}',
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 20),
              const Text(
                '아이디',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: TextButton(
                    onPressed: null,
                    child: const Text('중복 확인'),
                  ),
                ),
                onChanged: (value) {
                  _signUpController.updateUsername(value);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                '비밀번호',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  _signUpController.updatePassword(value);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                '비밀번호 확인',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  _signUpController.updateConfirmPassword(value);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_signUpController.isPasswordValid()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IdentityVerificationView(),  // 화면 전환
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                    );
                  }
                },
                child: const Text('다음', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF167DF9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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