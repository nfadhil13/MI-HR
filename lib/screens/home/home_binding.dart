import 'package:get/get.dart';
import 'package:movie_app/controller/absensi_global_controller.dart';
import 'package:movie_app/screens/home/home_controller.dart';

class HomeBinding implements Bindings {

  HomeBinding(){
    print("Home binding initialized");
  }

  @override
  void dependencies() {
    Get.put<AbsensiGlobalController>(AbsensiGlobalController("Home Binding"));
    Get.put<HomeController>(HomeController());
  }

}