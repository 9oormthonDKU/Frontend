// lib/controllers/id_card_camera_controller.dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class IDCardCameraController {
  File? _selectedImage;  // 선택된 이미지 파일 저장 변수
  final ImagePicker _picker = ImagePicker();  // image_picker 인스턴스

  // 사진 촬영 메서드
  Future<void> takePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);  // 카메라 호출
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);  // 파일 경로로 File 인스턴스 생성
    }
  }

  // 선택된 이미지 반환 메서드
  File? getSelectedImage() {
    return _selectedImage;
  }
}
