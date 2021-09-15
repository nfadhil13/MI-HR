import 'package:get/get.dart';
import 'package:movie_app/controller/absensi_global_controller.dart';
import 'package:movie_app/screens/map_screen/map_controller.dart';

class MapBinding implements Bindings {

  MapBinding(){
    print("Map binding initialized");
  }

  @override
  void dependencies() {
    Get.find<AbsensiGlobalController>();
    Get.put<MapController>(MapController());
  }

}