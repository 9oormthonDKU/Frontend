import 'package:flutter/material.dart';
import '../controllers/create_appointment_controller.dart';
import 'post_view.dart'; // PostPage import

class CreateAppointmentScreen extends StatefulWidget {
  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final CreateAppointmentController _controller = CreateAppointmentController();
  bool isLimitedParticipants = false; // 참가자 제한 상태
  int? maxParticipants; // 최대 참가자 수
  DateTime? selectedDate;
  String? selectedTime;
  int? selectedDistance;
  int? selectedPace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경을 흰색으로 설정
      appBar: AppBar(
        backgroundColor: Colors.white, // 상단 바 배경을 흰색으로 설정
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기
          },
        ),
        title: Text(
          '약속 만들기',
          style: TextStyle(color: Colors.black), // 글자 색을 검정으로 변경
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목 입력 필드
              TextField(
                decoration: InputDecoration(
                  labelText: '제목을 입력하세요',
                  border: InputBorder.none,  // 테두리 제거
                ),
                onChanged: (value) {
                  _controller.title = value;
                },
              ),
              Divider(color: Color(0xFFD9D9D9)), // 구분선
              SizedBox(height: 16),

              // 내용 입력 필드 with increased height
              TextField(
                maxLines: null,
                decoration: InputDecoration(
                  labelText: '내용을 입력하세요',
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _controller.details = value;
                },
              ),
              Divider(color: Color(0xFFD9D9D9)), // 구분선
              SizedBox(height: 16),

              // 장소 입력 필드
              Text('장소'),
              TextField(
                decoration: InputDecoration(
                  hintText: '집합 장소를 적어주세요',
                  suffixIcon: Icon(Icons.search, color: Colors.blue),
                  border: InputBorder.none,  // 테두리 제거
                ),
              ),
              SizedBox(height: 16),

              // 거리 선택 버튼
              Text('거리'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [3, 5, 10, 15, 20].map((distance) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedDistance == distance
                          ? Color(0xFF167DF9)
                          : Colors.white,
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedDistance = distance;
                        _controller.setDistance(distance);
                      });
                    },
                    child: Text(
                      '$distance km',
                      style: TextStyle(
                        color: selectedDistance == distance
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // 페이스 버튼
              Text('페이스'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [4, 5, 6, 7, 8].map((pace) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: selectedPace == pace
                          ? Color(0xFF167DF9)
                          : Colors.white,
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedPace = pace;
                        _controller.setPace(pace);
                      });
                    },
                    child: Text(
                      '${pace}:00',
                      style: TextStyle(
                        color: selectedPace == pace
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // 희망 인원
              Text('희망 인원'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildParticipantButton('인원 무관', false),
                  _buildParticipantButton('인원 제한', true),
                ],
              ),
              if (isLimitedParticipants) buildParticipantInput(),
              SizedBox(height: 16),

              // 일정 선택 버튼
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _showDatePicker(context);
                },
                child: Text(
                  '일정 선택',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 16),

              // 작성 완료 버튼 (긴 버튼, 둥근 테두리)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // 작성 완료 후 PostPage로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostPage(),
                      ),
                    );
                  },
                  child: Text(
                    '작성 완료',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantButton(String label, bool limited) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isLimitedParticipants == limited
            ? Color(0xFF167DF9)
            : Colors.white,
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: limited ? Radius.circular(0) : Radius.circular(20),
            right: limited ? Radius.circular(20) : Radius.circular(0),
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          isLimitedParticipants = limited;
          maxParticipants = null;
        });
      },
      child: Text(
        label,
        style: TextStyle(
          color: isLimitedParticipants == limited ? Colors.white : Colors.grey,
        ),
      ),
    );
  }

  Widget buildParticipantInput() {
    return Row(
      children: [
        Text("참가 인원: "),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              maxParticipants = int.tryParse(value);
            },
            decoration: InputDecoration(
              hintText: '인원 입력',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  // 하단에서 올라오는 달력과 시간 선택 (시간 추가 및 스크롤 가능)
  void _showDatePicker(BuildContext context) {
    DateTime selectedDateTemp = DateTime.now();
    String? selectedTimeTemp;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 600,
              child: Column(
                children: [
                  CalendarDatePicker(
                    initialDate: selectedDateTemp,
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                    onDateChanged: (newDate) {
                      setState(() {
                        selectedDateTemp = newDate;
                      });
                    },
                  ),
                  Text('시간 선택'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _buildTimeButtons(setState, selectedTimeTemp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = selectedDateTemp;
                        selectedTime = selectedTimeTemp;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('완료'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _buildTimeButtons(StateSetter setState, String? selectedTimeTemp) {
    return List.generate(24, (hour) {
      return List.generate(2, (index) {
        String time = '${hour.toString().padLeft(2, '0')}:${index == 0 ? '00' : '30'}';
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedTimeTemp = time;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedTimeTemp == time ? Colors.blue : Colors.white,
            ),
            child: Text(
              time,
              style: TextStyle(color: selectedTimeTemp == time ? Colors.white : Colors.grey),
            ),
          ),
        );
      });
    }).expand((i) => i).toList();
  }
}
