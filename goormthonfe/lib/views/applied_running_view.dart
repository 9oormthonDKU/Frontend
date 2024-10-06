import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/applied_running_model.dart';
import 'mainscreen_view.dart'; // MainScreen 페이지 import
import 'profile_view.dart'; // ProfileView import 추가

class AppliedRunningPage extends StatelessWidget {
  final List<RunningSession> appliedSessions;
  final List<RunningSession> createdSessions;

  AppliedRunningPage({
    required this.appliedSessions,
    required this.createdSessions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "나의 러닝",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // 아이콘 색상 설정
      ),
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: Column(
        children: [
          _buildCalendarSection(),  // 달력 섹션
          const SizedBox(height: 20),
          _buildRunningSessionsSection("신청한 러닝", appliedSessions.isEmpty ? _getMockAppliedSessions() : appliedSessions),
          const SizedBox(height: 20),
          _buildRunningSessionsSection("내가 만든 러닝", createdSessions.isEmpty ? _getMockCreatedSessions() : createdSessions),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),  // 하단 내비게이션 바
    );
  }

  // 달력 UI 섹션
  Widget _buildCalendarSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "2024년 10월",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_drop_down), // 년도 선택을 위한 드롭다운 아이콘
            ],
          ),
          const SizedBox(height: 10),
          // 실제 달력 위젯 추가
          TableCalendar(
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 10, 16),
            focusedDay: DateTime.now(),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // 러닝 세션 리스트 섹션
  Widget _buildRunningSessionsSection(String title, List<RunningSession> sessions) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  final session = sessions[index];
                  return Dismissible(
                    key: Key(session.time),  // 고유한 key 설정
                    direction: DismissDirection.endToStart,  // 오른쪽에서 왼쪽으로 스와이프
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.edit, color: Colors.white), // 수정 아이콘
                          SizedBox(width: 10),
                          Icon(Icons.delete, color: Colors.white), // 삭제 아이콘
                        ],
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final action = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('선택'),
                              content: Text('수정 또는 삭제를 선택하세요.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('수정'),
                                  onPressed: () {
                                    // 수정 로직 추가
                                    Navigator.of(context).pop('edit');
                                  },
                                ),
                                TextButton(
                                  child: Text('삭제'),
                                  onPressed: () {
                                    // 삭제 로직 추가
                                    Navigator.of(context).pop('delete');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        if (action == 'delete') {
                          return true;  // 삭제
                        }
                      }
                      return false;  // 수정 시 삭제하지 않음
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200], // 배경색 설정
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session.time,
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            session.description,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      ),
    );
  }

  // 테스트용 목업 데이터 추가
  List<RunningSession> _getMockAppliedSessions() {
    return [
      RunningSession(
        time: "오전 7:30",
        description: "아침에 가볍게 달려요~~",
        createdBy: User(userId: "1", userName: "홍길동"),
      ),
      RunningSession(
        time: "오후 8:00",
        description: "오늘 가볍게 달리실 분!",
        createdBy: User(userId: "2", userName: "김철수"),
      ),
    ];
  }

  List<RunningSession> _getMockCreatedSessions() {
    return [
      RunningSession(
        time: "오후 6:00",
        description: "저녁 달리기 같이 하실 분!",
        createdBy: User(userId: "3", userName: "박영희"),
        isCreatedByUser: true,
      ),
    ];
  }

  // 하단 내비게이션 바
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.run_circle_outlined), label: '나의러닝'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
      ],
      currentIndex: 1,  // '나의 러닝' 강조
      selectedItemColor: Colors.blue,
      onTap: (index) {
        if (index == 0) {
          // 홈 버튼을 눌렀을 때 MainScreen 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(), // MainScreen 페이지로 이동
            ),
          );
        } else if (index == 2) {
          // 마이페이지 버튼을 눌렀을 때 ProfileView 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileView(), // ProfileView 페이지로 이동
            ),
          );
        }
      },
    );
  }
}
