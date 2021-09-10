
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/provider/absensi_provider.dart';
import 'package:movie_app/screens/home/attendance_home_item.dart';
import 'package:movie_app/screens/home/home_attendance_list.dart';
import 'package:movie_app/screens/home/home_attendance_title.dart';
import 'package:movie_app/screens/home/home_departments_title.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/MainDrawer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = "/home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Provider.of<AbsensiProvider>(context,listen: false).getAbsensiList();
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
        ),
      ),
    );
  }
}






