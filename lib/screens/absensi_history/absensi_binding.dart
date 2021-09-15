import 'package:get/get.dart';
import 'package:movie_app/controller/absensi_global_controller.dart';
import 'package:movie_app/screens/absensi_history/absensi_history_controller.dart';

class AbsensiBinding implements Bindings {
  @override
  void dependencies() {
    Get.find<AbsensiGlobalController>();
    Get.put<AbsensiHistoryController>(AbsensiHistoryController());
  }

}