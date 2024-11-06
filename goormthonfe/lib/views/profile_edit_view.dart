import 'package:flutter/material.dart';
import '../controllers/profile_edit_controller.dart';
import '../models/profile_edit_model.dart';

class ProfileEditView extends StatefulWidget {
  final ProfileEditModel profileEditModel;

  const ProfileEditView({Key? key, required this.profileEditModel}) : super(key: key);

  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  late ProfileEditModel _profileEditModel;
  late ProfileEditController _profileEditController;

  @override
  void initState() {
    super.initState();
    _profileEditModel = widget.profileEditModel;
    _profileEditController = ProfileEditController(_profileEditModel);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _profileEditModel.birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _profileEditModel.birthDate) {
      setState(() {
        _profileEditController.updateBirthDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('프로필 설정', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context, _profileEditModel);
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
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('이름', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: TextEditingController(text: _profileEditModel.name),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _profileEditController.updateName(value);
                },
              ),
              const SizedBox(height: 30),
              const Text('성별', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Radio<String>(
                    value: '남성',
                    groupValue: _profileEditModel.gender,
                    onChanged: (String? value) {
                      setState(() {
                        _profileEditController.updateGender(value!);
                      });
                    },
                  ),
                  const Text('남성'),
                  Radio<String>(
                    value: '여성',
                    groupValue: _profileEditModel.gender,
                    onChanged: (String? value) {
                      setState(() {
                        _profileEditController.updateGender(value!);
                      });
                    },
                  ),
                  const Text('여성'),
                ],
              ),
              const SizedBox(height: 30),
              const Text('생년월일', style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: TextEditingController(
                    text: '${_profileEditModel.birthDate.year}-${_profileEditModel.birthDate.month}-${_profileEditModel.birthDate.day}'),
                readOnly: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 30),
              const Text('신원확인', style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: TextEditingController(text: _profileEditModel.verificationStatus),
                readOnly: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text('목표', style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: TextEditingController(text: _profileEditModel.goal),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _profileEditController.updateGoal(value);
                },
              ),
              const SizedBox(height: 30),
              const Text('위치', style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: TextEditingController(text: _profileEditModel.location),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _profileEditController.updateLocation(value);
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, _profileEditModel);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: const Color(0xFF167DF9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('변경하기', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
