
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/absensi_global_controller.dart';
import 'package:movie_app/provider/provider_state.dart';
import 'package:movie_app/screens/home/widgets/home_attendance_list.dart';
import 'package:movie_app/screens/home/widgets/home_attendance_title.dart';
import 'package:movie_app/screens/home/widgets/home_departments_title.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/MainDrawer.dart';
import 'package:sizer/sizer.dart';

import 'home_controller.dart';
import 'widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = "/home-screen";

  @override
  Widget build(BuildContext context) {
    final absensiController = Get.find<AbsensiGlobalController>();
    final homeController = Get.find<HomeController>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.primaryThird,
            elevation: 0,
            iconTheme: IconThemeData(color: ThemeColors.primaryOne),
          ),
          drawer: Drawer(
            child: MainDrawer(),
          ),
          backgroundColor: ThemeColors.primarySecond,
          body: RefreshIndicator(
            onRefresh: () async {
              absensiController.getAbsensiList();
              homeController.getUser();
            },
            child: CustomScrollView(
              slivers: [
                SliverList(delegate: SliverChildListDelegate.fixed(
                    [
                      HomeHeader(),
                      SizedBox(height: 10.w),
                      HomeAttendanceTitle(),
                      SizedBox(height : 1.25.h)
                    ]
                )),
                HomeAttendanceList(),
                SliverList(delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(height: 5.w),
                      HomeDepartmentTitle(),
                      SizedBox(height : 1.25.h)
                    ]
                )),
              ],
            )
          ),
        ),
        Obx((){
          final currentState = absensiController.currentState;
          if(currentState.value == ProviderState.Loading){
            return Positioned.fill(child: Container(
                color: Colors.black45,
                child: Center(child: CircularProgressIndicator(
                  color: ThemeColors.primaryThird,
                ),)
            ));
          }
          return SizedBox();
        })
      ],
    );
  }
}






