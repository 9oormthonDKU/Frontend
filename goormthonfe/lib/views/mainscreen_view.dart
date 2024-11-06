import 'package:flutter/material.dart';
import '../models/mainscreen_model.dart';
import '../controllers/mainscreen_controller.dart';
import 'applied_running_view.dart'; // AppliedRunningPage import 추가
import 'profile_view.dart'; // ProfileView import 추가

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final RunController runController = RunController();
  late List<bool> isJoinedList; // 각 카드의 버튼 상태를 저장하는 리스트
  int _selectedIndex = 0; // 선택된 인덱스를 관리할 변수 추가

  @override
  void initState() {
    super.initState();
    isJoinedList = List<bool>.generate(runController.getRuns().length, (index) => false); // 초기 상태 설정
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      // 나의 러닝을 선택했을 때 AppliedRunningPage로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppliedRunningPage(
            appliedSessions: [], // 임시 빈 리스트 전달
            createdSessions: [], // 임시 빈 리스트 전달
          ),
        ),
      );
    } else if (index == 2) {
      // 마이페이지 선택 시 ProfileView로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileView(), // ProfileView 페이지로 이동
        ),
      );
    } else {
      // 다른 메뉴를 선택했을 때는 단순히 index 업데이트
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 검색창
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                labelText: '검색',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // 제목과 위치 정보
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '오늘은 누구와 달려볼까요?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '용인시 러닝', // 위치 정보 추가
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // 위치 기반 러닝 (가로 스크롤)
          Container(
            height: 378, // 카드 크기 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // 가로 스크롤 설정
              itemCount: runController.getRuns().length,
              itemBuilder: (context, index) {
                Run run = runController.getRuns()[index];
                return Container(
                  width: 280, // 카드 크기 너비 설정
                  margin: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color(0xFFE9F3FF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 위치 정보에 흰색 테두리 추가
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // 배경색 설정
                            borderRadius: BorderRadius.circular(24), // 테두리 반경
                            border: Border.all(color: Colors.white, width: 1), // 테두리 설정
                          ),
                          child: Text(
                            '${run.location}', // run.location 사용
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            run.title,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('오늘의 목표: 5km | 오후 6:30'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('장소: 단국대학교 죽전캠퍼스 대운동장'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('날짜: 2024년 10월 4일 금요일'),
                        ),
                        Spacer(),
                        Center( // 버튼을 중앙 정렬하기 위한 Center 위젯
                          child: Column( // 버튼과 Spacer를 포함한 Column 추가
                            children: [
                              SizedBox(height: 16), // 위쪽 여백 추가
                              SizedBox(
                                width: 248, // 버튼 크기 고정
                                height: 46,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isJoinedList[index] ? Color(0xFFE5E5E5) : Color(0xFF167DF9), // 버튼 색상 변경
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isJoinedList[index] = !isJoinedList[index]; // 버튼 상태 변경
                                    });
                                  },
                                  child: Text(
                                    isJoinedList[index] ? '취소하기' : '같이 달리기',
                                    style: TextStyle(
                                      color: isJoinedList[index] ? Colors.black : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16), // 아래쪽 여백 추가
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // 오늘의 인기 러닝
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '오늘의 인기 러닝',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // 인기 러닝 카드 (세로 스크롤)
          Expanded( // Expand 위젯 추가
            child: ListView.builder(
              scrollDirection: Axis.vertical, // 세로 스크롤 설정
              itemCount: runController.getPopularRuns().length,
              itemBuilder: (context, index) {
                Run popularRun = runController.getPopularRuns()[index];
                return Container(
                  width: 353, // 카드 너비 설정
                  height: 150, // 카드 높이 설정
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2), // 배경색 설정
                    borderRadius: BorderRadius.circular(12), // 테두리 반경
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 위치 정보를 흰색 테두리로 추가
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // 배경색 설정
                            borderRadius: BorderRadius.circular(12), // 테두리 반경
                            border: Border.all(color: Colors.white, width: 1), // 테두리 설정
                          ),
                          child: Text(
                            popularRun.location,
                            style: TextStyle(color: Colors.black), // 글씨 색상
                          ),
                        ),
                        SizedBox(height: 6), // 텍스트와 다른 요소 간의 간격 추가
                        Text(
                          popularRun.title,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18), // 글씨 크기 18로 변경
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('5km | 오후 6:30'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('10월 4일(금)'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // 하단 내비게이션 바 추가
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.run_circle_outlined), label: '나의러닝'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 탭 인덱스
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, // 탭 선택 시 호출되는 함수
      ),
    );
  }
}