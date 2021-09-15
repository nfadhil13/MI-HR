import 'package:movie_app/datasource/mapper.dart';
import 'package:movie_app/datasource/network/models/user_dto.dart';
import 'package:movie_app/datasource/network/network_const.dart';
import 'package:movie_app/models/user.dart';

class UserMapper extends OneWay<UserDto, User> {
  @override
  User mapToDomain(UserDto input) {
    return User.createUserWithDefaultImage(id: input.id, name: input.name, jobTitle: input.jobTitle ,
      imageProfileURL: input.image1920 != null ? "${NetworkConst.baseURL}${input.image1920}" : null
    );
  }

}