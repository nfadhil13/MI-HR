import 'package:get/get.dart';

class AbsensiHistoryController extends GetxController {

  var currentDateTime = DateTime.now().obs;


  void setDate(DateTime newDate){
    currentDateTime.value = newDate;
  }

}