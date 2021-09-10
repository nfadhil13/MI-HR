
import 'package:flutter/material.dart';
import 'package:movie_app/util/color.dart';
import 'package:sizer/sizer.dart';


class HomeAttendanceTitle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Attendance History", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp
              ),),
              Expanded(child: SizedBox()),
              Text("More History", style: TextStyle(
                  color: ThemeColors.primaryThird,
                  fontSize: 10.sp
              ))
            ],
          )
        ],
      ),
    );
  }
}