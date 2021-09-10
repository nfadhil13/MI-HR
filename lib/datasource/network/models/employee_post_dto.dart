import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class EmployeePostDto {
  final String name;
  final String email;
  final int departmentId;
  final XFile imageFile;

  EmployeePostDto(this.name, this.email, this.departmentId, this.imageFile);


  Future<String> toJson() async{
    List<int> imgBytes = await imageFile.readAsBytes();
    return jsonEncode({
      "name" : this.name,
      "image_1920" : base64Encode(imgBytes).toString(),
      "department_id" : departmentId,
      "work_email" : this.email
    });
  }

}