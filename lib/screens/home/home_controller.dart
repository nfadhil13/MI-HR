import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/user.dart';
import 'package:movie_app/repository/user_repository.dart';
import 'package:movie_app/screens/login/login_screen.dart';

class HomeController extends GetxController{

  var currentUser = Rxn<User?>();
  var _userRepository = UserRepository();
  var _isLoading = false.obs;
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  void getUser() async{
    _isLoading.value = true;
    final result = await _userRepository.getUserProfile();
    _isLoading.value = false;
    result.whenWithResult(
        success: (data) {
          currentUser.value = data.data;
        },
        error: (value){
          Get.rawSnackbar(
              message: value.message,
              backgroundColor: Colors.redAccent
          );
        },
        notAuthorize: (data){
          Get.offAllNamed(LoginScreen.routeName);
        }
    );
  }


}