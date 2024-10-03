import 'package:flutter/material.dart';
import '../controllers/profile_controller.dart';
import '../models/profile_model.dart';
import '../models/profile_edit_model.dart';
import 'profile_edit_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileModel _profileModel = ProfileModel(
    name: '김단국',
    age: '31세',
    job: '회사원',
    gender: '여성',
    birthDate: DateTime(2000, 1, 1),
    verificationStatus: '인증 완료',
    goal: '12km',  // 목표값을 기본값으로 설정 (12km)
    location: '경기도 용인시 수지구 전체',
  );

  late ProfileController _profileController;

  @override
  void initState() {
    super.initState();
    _profileController = ProfileController(_profileModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: AppBar(
        title: const Text('마이페이지'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // 알림 클릭 로직
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              const SizedBox(height: 20),
              _buildRunningGoalSection(),  // 러닝 목표 섹션 추가
              const SizedBox(height: 20),
              _buildLocationSection(),
              const SizedBox(height: 20),
              _buildMyRunningSection(),
            ],
          ),
        ),
      ),
    );
  }

  // 프로필 섹션
  Widget _buildProfileSection() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _profileModel.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('${_profileModel.age} ${_profileModel.job}'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            // ProfileModel 데이터를 기반으로 ProfileEditModel 생성
            final profileEditModel = ProfileEditModel(
              name: _profileModel.name,
              gender: _profileModel.gender,
              birthDate: _profileModel.birthDate,
              verificationStatus: _profileModel.verificationStatus,
              goal: _profileModel.goal,  // 현재 목표를 전달
              location: _profileModel.location,
            );

            // 프로필 수정 페이지로 이동하고 결과 받기
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditView(profileEditModel: profileEditModel),
              ),
            );

            if (result != null && result is ProfileEditModel) {
              // 수정된 데이터를 받아서 화면을 갱신
              setState(() {
                _profileModel = ProfileModel(
                  name: result.name,
                  gender: result.gender,
                  birthDate: result.birthDate,
                  verificationStatus: result.verificationStatus,
                  goal: result.goal,  // 수정된 목표 반영
                  location: result.location,
                  age: _profileModel.age,  // 기존 age, job 값 유지
                  job: _profileModel.job,
                );
                _profileController = ProfileController(_profileModel);
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],  // 기존 primary 대신 backgroundColor 사용
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('수정하기', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  // 러닝 목표 섹션
  Widget _buildRunningGoalSection() {
    // 목표 런닝 값에서 km를 제거하고 숫자 값만 사용하여 계산
    double goalDistance = double.tryParse(_profileModel.goal.replaceAll('km', '').trim()) ?? 12.0;
    double todayRunningDistance = 7.31;  // 예시로 오늘의 런닝 거리 설정

    return Card(
      elevation: 0,
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('오늘의 런닝', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Text('$todayRunningDistance km', style: TextStyle(fontSize: 16, color: Colors.blue[700])),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: todayRunningDistance / goalDistance,  // 수정된 목표 값으로 계산
              color: Colors.blue,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 5),
            Text('목표 런닝 ${_profileModel.goal}', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // 활동한 위치 섹션
  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '활동한 위치',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          children: [
            _buildLocationChip('경기도 용인시 수지구 전체'),
            _buildLocationChip('육전'),
          ],
        ),
      ],
    );
  }

  // 위치 정보 Chip
  Widget _buildLocationChip(String location) {
    return Chip(
      label: Text(location),
      backgroundColor: Colors.grey[200],
    );
  }

  // 나의 러닝, 신청한 러닝, 내가 만든 러닝, 로그아웃 섹션
  Widget _buildMyRunningSection() {
    return Column(
      children: [
        _buildListTile('나의 러닝', onTap: () {
          // 나의 러닝 클릭 시 로직
        }),
        _buildListTile('신청한 러닝', trailing: const Icon(Icons.arrow_forward_ios)),
        _buildListTile('내가 만든 러닝', trailing: const Icon(Icons.arrow_forward_ios)),
        _buildListTile('로그아웃 / 회원탈퇴', onTap: () {
          // 로그아웃/회원탈퇴 로직
        }),
      ],
    );
  }

  // 리스트 타일 컴포넌트
  Widget _buildListTile(String title, {Widget? trailing, Function()? onTap}) {
    return ListTile(
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
