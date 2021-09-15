import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/base_controller.dart';
import 'package:movie_app/repository/absensi_repository.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'package:movie_app/util/single_event.dart';

class MapController extends BaseController{

  var _absensiRepository = AbsensiRepository();


  void checkIn(double latitude, double longitude){
    fetch(() => _absensiRepository.checkIn(latitude, longitude), (data) {
      Get.offAllNamed(HomeScreen.routeName);
    }, onError: (message) {
      Get.rawSnackbar(
          message: errorMessage,
          backgroundColor: Colors.redAccent
      );
    });
  }

  void checkOut(double latitude, double longitude){
    fetch(() => _absensiRepository.checkOut(latitude, longitude), (data) {
      Get.offAllNamed(HomeScreen.routeName);
    },
        onError: (message){
          Get.rawSnackbar(
              message: errorMessage,
              backgroundColor: Colors.redAccent
          );
        }
    );
  }

}