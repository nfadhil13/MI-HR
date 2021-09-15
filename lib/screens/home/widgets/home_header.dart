import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/controller/absensi_global_controller.dart';
import 'package:movie_app/datasource/cache/service/user_dao.dart';
import 'package:movie_app/screens/getting_location_screen/getting_location_screen.dart';
import 'package:movie_app/screens/home/home_controller.dart';
import 'package:movie_app/screens/login/login_screen.dart';
import 'package:movie_app/util/color.dart';
import 'package:sizer/sizer.dart';

class HomeHeader extends StatelessWidget {


  final AbsensiGlobalController _absensiGlobalController = Get.find<AbsensiGlobalController>();


  Widget _buildCheckInText(String time, String text) {
    return Column(
        children: [
          Text(time, style: TextStyle(
              color: ThemeColors.primarySecond, fontSize: 18.sp),),
          SizedBox(height: 10),
          Text(text, style: TextStyle(
              color: ThemeColors.primarySecond, fontSize: 10.sp))
        ]
    );
  }


  Widget _buildAttendanceSection(BuildContext context) {
    return Obx(() {
      final lastAbsensi = _absensiGlobalController.lastAbsensi.value;
      return Stack(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: 76.w,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 10),
                      Text(DateFormat.MMMEd().format(DateTime.now()),
                          style: TextStyle(
                              color: ThemeColors.primarySecond,
                              fontSize: 10.sp
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCheckInText(lastAbsensi?.getCheckInHour() ??
                                "--:--", "Check In"),
                            _buildCheckInText(lastAbsensi?.getCheckoutHour() ??
                                "--:--", "Check Out"),
                          ],
                        ),
                      ),
                      Text("", style: TextStyle(
                          color: ThemeColors.primarySecond,
                          fontSize: 4.sp
                      )),
                    ]
                ),
              )
          ),
          Positioned.fill(
              child: AlignPositioned(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ThemeColors.primaryThird,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                    ),
                    onPressed: () {
                      Get.toNamed(GettingLocationScreen.routeName);
                    },
                    child: Container(
                      width: 50.w,
                      child: Row(
                          children: [
                            Text(
                                lastAbsensi == null ? "Check In" : "Check Out"),
                            Expanded(child: SizedBox()),
                            Icon(Icons.navigate_next, color: Colors.white)
                          ]
                      ),
                    )
                ),
                moveByChildHeight: 0.4,
              )
          )
        ],
      );
    });
  }

  Widget _buildProfileImageFromURL(String imageURL){
    return FutureBuilder<String?>(
      future: UserDao().getLastLoginUserSession(),
      builder: (ctx, snapshot){
        if(snapshot.hasData){
          if(snapshot.data != null){
            return CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: Image.network(
                  imageURL,
                  headers: {
                    'Cookie' : snapshot.data!
                  },
                  errorBuilder:(_, __, ___)  {
                    return Text("Error");
                  },
                  fit: BoxFit.cover,
                ).image
            );
          }else{
            Get.offAllNamed(LoginScreen.routeName);
          }
        }
        if(snapshot.hasError){
          print(snapshot.error);
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _homeController = Get.find<HomeController>();
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/img/home_bg.png", height: 27.h,
              width: double.infinity,
              fit: BoxFit.fill),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 1.h),
            child: Obx(() {
              final userProfile = _homeController.currentUser.value;
              if (userProfile != null) {
                return Row(
                  children: [
                    !userProfile.isImageFromURL || true ? CircleAvatar(
                        backgroundImage:Image.asset("assets/img/profile_pic.jpg").image
                    ) : _buildProfileImageFromURL(userProfile.imageProfileURL),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hi, ${userProfile.name}", style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold
                        )),
                        Text(userProfile.jobTitle, style: TextStyle(
                            fontSize: 10.sp
                        ))
                      ],
                    )
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _buildAttendanceSection(context),
          ),
        )
      ],
    );
  }
}