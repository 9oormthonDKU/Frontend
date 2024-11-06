// lib/models/id_card_camera_model.dart
import 'dart:io';

class IDCardCameraModel {
  File? imageFile;

  // 이미지 파일을 설정하는 메서드
  void setImageFile(File file) {
    imageFile = file;
  }
}