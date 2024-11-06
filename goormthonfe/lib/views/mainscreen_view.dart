import 'package:flutter/material.dart';
import '../models/mainscreen_model.dart';
import '../controllers/mainscreen_controller.dart';
import 'create_appointment_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final RunController runController = RunController();
  final PageController _pageController = PageController(viewportFraction: 0.8);
  late List<bool> isJoinedList;

  @override
  void initState() {
    super.initState();
    isJoinedList = List<bool>.generate(runController.getRuns().length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 로고와 돋보기 아이콘
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 40,
                  height: 40,
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.search, size: 28),
                  onPressed: () {
                    // 검색 기능 추가 가능
                  },
                ),
              ],
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
                  '용인시 러닝',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // 위치 기반 러닝 (가로 스크롤)
          Container(
            height: 400,
            child: PageView.builder(
              controller: _pageController,
              itemCount: runController.getRuns().length,
              itemBuilder: (context, index) {
                Run run = runController.getRuns()[index];
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeOut.transform(value) * 370,
                        width: Curves.easeOut.transform(value) * 300,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFE9F3FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFF167DF9), width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            '${run.location}',
                            style: TextStyle(color: Color(0xFF167DF9), fontWeight: FontWeight.bold),
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
                          child: Text('오늘의 목표: 5km | 오후 6:30', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                              SizedBox(width: 4),
                              Text('단국대학교 죽전캠퍼스 대운동장', style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.grey[600], size: 16),
                              SizedBox(width: 4),
                              Text('9월 29일 (일) 오후 8:00', style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                        Spacer(),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              SizedBox(
                                width: 248,
                                height: 46,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isJoinedList[index] ? Color(0xFFE5E5E5) : Color(0xFF167DF9),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isJoinedList[index] = !isJoinedList[index];
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
                              SizedBox(height: 16),
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: runController.getPopularRuns().length,
              itemBuilder: (context, index) {
                Run popularRun = runController.getPopularRuns()[index];
                return Container(
                  width: 353,
                  height: 150,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            popularRun.location,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          popularRun.title,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateAppointmentScreen()),
          );
        },
        label: Text('약속 만들기', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF167DF9),
        icon: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
