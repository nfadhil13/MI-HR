import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/provider/absensi_provider.dart';
import 'package:movie_app/screens/absensi/absensi_screen.dart';
import 'package:movie_app/screens/getting_location_screen/getting_location_screen.dart';
import 'package:movie_app/util/color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);


  Widget _buildCheckInText(String time, String text) {
    return Column(
        children: [
          Text(time, style: TextStyle(color: ThemeColors.primarySecond, fontSize: 18.sp),),
          SizedBox(height : 10),
          Text(text, style: TextStyle(color: ThemeColors.primarySecond, fontSize: 10.sp))
        ]
    );
  }



  Widget _buildAttendanceSection(BuildContext context) {
    return Consumer<AbsensiProvider>(
      builder: (_, provider, __) {
        final lastAbsensi = provider.lastAbsensi();
        print(provider.shouldCheckIn());
        print(lastAbsensi);
        return Stack(
          children: [
            Card(
                shape : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  width: 76.w,
                  child: Column(
                      mainAxisSize : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height:10),
                        Text(DateFormat.MMMEd().format(DateTime.now()), style: TextStyle(
                            color: ThemeColors.primarySecond,
                            fontSize: 10.sp
                        )),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              _buildCheckInText(lastAbsensi?.getCheckInHour() ?? "--:--", "Check In"),
                              _buildCheckInText(lastAbsensi?.getCheckoutHour() ?? "--:--", "Check Out"),
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
                child:  AlignPositioned(
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
                        Navigator.pushNamed(context, GettingLocationScreen.routeName);
                      },
                      child: Container(
                        width: 50.w,
                        child: Row(
                            children:[
                              Text(lastAbsensi == null ? "Check In" : "Check Out"),
                              Expanded(child: SizedBox()),
                              Icon(Icons.navigate_next, color : Colors.white)
                            ]
                        ),
                      )
                  ),
                  moveByChildHeight: 0.4,
                )
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child:  Image.asset("assets/img/home_bg.png", height: 27.h, width: double.infinity, fit: BoxFit.fill),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 1.h),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/img/profile_pic.jpg")
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi, Karuma Ichi", style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold
                    )),
                    Text("Admin", style: TextStyle(
                        fontSize: 10.sp
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child:  _buildAttendanceSection(context),
          ),
        )
      ],
    );
  }
}