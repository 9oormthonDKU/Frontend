import 'package:flutter/material.dart';
import '../controllers/create_appointment_controller.dart';
import 'post_view.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '약속 만들기',
          style: TextStyle(color: Colors.black),
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
              _buildTextField('제목을 입력하세요', (value) => _controller.title = value),
              Divider(color: Color(0xFFD9D9D9)),
              _buildTextField('내용을 입력하세요', (value) => _controller.details = value, maxLines: 3),
              Divider(color: Color(0xFFD9D9D9)),
              SizedBox(height: 16),
              _buildDateSelector(), // 일정 선택을 희망 인원 위로 이동
              SizedBox(height: 16),
              _buildParticipantSelector(),
              SizedBox(height: 16),
              _buildLocationField(),
              SizedBox(height: 16),
              _buildDistanceSelector(), // 거리 선택 부분
              SizedBox(height: 16),
              _buildPaceSelector(), // 페이스 선택 부분
              SizedBox(height: 24),
              _buildCompleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, Function(String) onChanged, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: hintText,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('장소'),
        TextField(
          decoration: InputDecoration(
            hintText: '집합 장소를 적어주세요',
            suffixIcon: Icon(Icons.search, color: Colors.blue),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('거리'),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [3, 5, 10, 15, 20].map((distance) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: selectedDistance == distance ? Color(0xFF167DF9) : Colors.white,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => setState(() {
                    selectedDistance = distance;
                    _controller.setDistance(distance);
                  }),
                  child: Text(
                    '$distance km',
                    style: TextStyle(color: selectedDistance == distance ? Colors.white : Colors.grey),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('페이스'),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [4, 5, 6, 7, 8].map((pace) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: selectedPace == pace ? Color(0xFF167DF9) : Colors.white,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => setState(() {
                    selectedPace = pace;
                    _controller.setPace(pace);
                  }),
                  child: Text(
                    '$pace:00',
                    style: TextStyle(color: selectedPace == pace ? Colors.white : Colors.grey),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('희망 인원'),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildParticipantButton('인원 무관', false)),
            Expanded(child: _buildParticipantButton('인원 제한', true)),
          ],
        ),
        if (isLimitedParticipants) _buildParticipantInput(),
      ],
    );
  }

  Widget _buildParticipantButton(String label, bool limited) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: isLimitedParticipants == limited ? Color(0xFF167DF9) : Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: limited ? Radius.circular(0) : Radius.circular(20),
            right: limited ? Radius.circular(20) : Radius.circular(0),
          ),
        ),
      ),
      onPressed: () => setState(() {
        isLimitedParticipants = limited;
        maxParticipants = null;
      }),
      child: Text(
        label,
        style: TextStyle(color: isLimitedParticipants == limited ? Color(0xFF167DF9) : Colors.grey),
      ),
    );
  }

  Widget _buildParticipantInput() {
    return Column(
      children: [
        SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => maxParticipants = int.tryParse(value),
          decoration: InputDecoration(
            hintText: '인원을 설정해주세요',
            border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFD9D9D9))),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('일정', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () => _showDatePicker(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedDate == null || selectedTime == null
                    ? '일정을 설정해주세요'
                    : '${selectedDate!.year}년 ${selectedDate!.month}월 ${selectedDate!.day}일 $selectedTime',
                style: TextStyle(color: Colors.grey),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage()),
          );
        },
        child: Text(
          '작성 완료',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    DateTime tempDate = selectedDate ?? DateTime.now();
    String? tempTime = selectedTime;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Theme(
              data: ThemeData(
                colorScheme: ColorScheme.light(
                  primary: Color(0xFF167DF9),
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: Container(
                color: Colors.white,
                height: 600,
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
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                    SizedBox(height: 8),
                    CalendarDatePicker(
                      initialDate: tempDate,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2025),
                      onDateChanged: (newDate) {
                        setState(() {
                          tempDate = newDate;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    Text('시간', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _buildTimeButtons(setState, tempTime),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => setState(() {
                            tempDate = DateTime.now();
                            tempTime = null;
                          }),
                          child: Text('초기화', style: TextStyle(color: Colors.grey)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            this.setState(() {
                              selectedDate = tempDate;
                              selectedTime = tempTime;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF167DF9),
                          ),
                          child: Text('완료', style: TextStyle(color: Colors.white)),
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

  List<Widget> _buildTimeButtons(StateSetter setState, String? selectedTimeTemp) {
    return List.generate(24, (hour) {
      return List.generate(2, (index) {
        String time = '${hour.toString().padLeft(2, '0')}:${index == 0 ? '00' : '30'}';
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            onPressed: () => setState(() {
              selectedTimeTemp = time;
              selectedTime = time;
            }),
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedTimeTemp == time ? Color(0xFF167DF9) : Colors.white,
              side: BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(time, style: TextStyle(color: selectedTimeTemp == time ? Colors.white : Colors.grey)),
          ),
        );
      });
    }).expand((i) => i).toList();
  }
}
