import 'package:flutter/material.dart';
import '../controllers/create_appointment_controller.dart';

class CreateAppointmentScreen extends StatefulWidget {
  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final CreateAppointmentController _controller =
      CreateAppointmentController();
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
                    backgroundColor: Colors.blue,  // 파란색 배경
                    minimumSize: Size(double.infinity, 50),  // 가로로 긴 버튼
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),  // 테두리 반경 20px
                    ),
                  ),
                  onPressed: () {
                    // 작성 완료 로직
                  },
                  child: Text(
                    '작성 완료',
                    style: TextStyle(color: Colors.white),  // 글자색 흰색
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
          borderRadius: BorderRadius.circular(20),
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
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  int? inputValue;
                  return AlertDialog(
                    title: Text('참가자 수 입력'),
                    content: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        inputValue = int.tryParse(value);
                      },
                      decoration: InputDecoration(
                        hintText: '인원 입력',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (inputValue != null) {
                            setState(() {
                              maxParticipants = inputValue;
                            });
                          }
                          Navigator.pop(context);
                        },
                        child: Text('확인'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(maxParticipants == null
                ? '인원 수 입력'
                : '$maxParticipants 명'),
          ),
        ),
      ],
    );
  }

  // 하단에서 올라오는 달력과 시간 선택 (시간 추가 및 스크롤 가능)
  void _showDatePicker(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    String? selectedTime;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white, // 달력의 배경색 일치
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Theme(
              data: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: Color(0xFF167DF9), // 선택된 날짜의 색상을 버튼 색상으로 설정
                ),
              ),
              child: Container(
                height: 600, // 높이 확대
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          '일정',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                    SizedBox(height: 8),

                    // 달력
                    CalendarDatePicker(
                      initialDate: selectedDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2025),
                      onDateChanged: (newDate) {
                        setState(() {
                          selectedDate = newDate;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Text('시간'),
                    SizedBox(height: 8),

                    // 시간 선택 버튼 (30분 단위 스크롤 가능)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _buildTimeButtons(setState),
                        ),
                      ),
                    ),
                    Spacer(),

                    // 초기화와 완료 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.grey),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedDate = DateTime.now();
                              selectedTime = null;
                            });
                          },
                          child: Text(
                            '초기화',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: BorderSide(color: Colors.grey),
                          ),
                          onPressed: () {
                            _controller.setDate(selectedDate);
                            if (selectedTime != null) {
                              _controller.setTimeSlot(selectedTime!);
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            '완료',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // 30분 단위 시간 버튼 생성 함수
  List<Widget> _buildTimeButtons(StateSetter setState) {
    List<Widget> buttons = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String time = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        buttons.add(
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedTime == time
                    ? Color(0xFF167DF9)
                    : Colors.white,
                side: BorderSide(color: Colors.grey), // 테두리 색상 일치
              ),
              onPressed: () {
                setState(() {
                  selectedTime = time;
                });
              },
              child: Text(
                time,
                style: TextStyle(
                  color: selectedTime == time ? Colors.white : Colors.grey, // 거리 글씨 색상
                ),
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }
}
