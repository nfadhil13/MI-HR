import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/repository/user_repository.dart';
import 'package:movie_app/screens/home/home_screen.dart';

class LoginController extends GetxController {

  var _userRepository = UserRepository();

  var isFetching = false;

  final GlobalKey buttonKey = GlobalKey();

  var _username = "";
  var _password = "";



  final passwordFocus = FocusNode();

  final form = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }


  Future<void> login(String _username,String _password,) async{
    isFetching = true;
    update();
    final result = await _userRepository.login(_username, _password);
    isFetching = false;
    result.whenWithResult(
        success: (value) {
          Get.offNamed(HomeScreen.routeName);
        },
        error: (value) {
          Get.rawSnackbar(
            message: value.message,
            backgroundColor: Colors.redAccent
          );
        }
    );
    update();
  }

  void setUsername(String username){
    this._username = username;
  }

  void setPassword(String password){
    this._password = password;
  }

  void save() {
    final currentState = form.currentState;
    print(currentState);
    if (currentState != null && currentState.validate()) {
      currentState.save();
      login(_username, _password);
    }
  }
}