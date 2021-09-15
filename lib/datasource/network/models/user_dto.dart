import 'package:movie_app/datasource/JSONParser.dart';

/// id : 7626
/// name : "Alex"
/// image_1920 : "/web/image?model=res.employee&field=image_1920&id=7626"
/// job_title : "Design - Graphics"
/// gender : "male"

class UserDto {
  int id;
  String name;
  String? image1920;
  String jobTitle;



  UserDto({
    required  this.id,
    required  this.name,
    this.image1920,
    required this.jobTitle});


  static UserDto  fromJson(Map<String, dynamic> json) {
    return UserDto(
        id :  json['id'],
        name : SafeCaster.tryCastAndDefault<dynamic,String>(json['name'], "Unkown") ,
        image1920 :  SafeCaster.tryCast<dynamic,String>(json['image_1920']) ,
        jobTitle : SafeCaster.tryCastAndDefault(json['job_title'], "Unkown")
    );
  }


}