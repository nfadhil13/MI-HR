import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/absensi_global_controller.dart';
import 'package:movie_app/screens/home/widgets/attendance_home_item.dart';
import 'package:sizer/sizer.dart';
class HomeAttendanceList extends StatelessWidget {
  const HomeAttendanceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final absensiController = Get.find<AbsensiGlobalController>();
    return  SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        height: 20.h,
        child: Obx( () {
          final absensiList = absensiController.absensiList.take(5).toList();
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx , index) => AttendanceHomeItem(absensiList[index]),
            itemCount: absensiList.length,
          );
        }
        ),
      ),
    );
  }

}

