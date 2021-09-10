import 'package:flutter/material.dart';
import 'package:movie_app/util/color.dart';
import 'package:sizer/sizer.dart';
class AttendanceHomeItem extends StatelessWidget {
  const AttendanceHomeItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              children: [
                Text("Monday, 27 Agustus 2020", style: TextStyle(
                    fontSize: 9.sp,

                )),
                Expanded(child: FittedBox(child: Text("M", style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: ThemeColors.primarySecond
                ),))),
                Text("Check In   08:00", style: TextStyle(
                    fontSize: 9.sp
                )),
                Text("Check Out   09:00", style: TextStyle(
                    fontSize: 9.sp
                ))
              ],
            )
        ),
      ),
    );
  }
}