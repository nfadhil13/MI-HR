import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/absensi.dart';
import 'package:movie_app/util/color.dart';
import 'package:sizer/sizer.dart';
class AttendanceHomeItem extends StatelessWidget {


  final Absensi _absensi;

  AttendanceHomeItem(this._absensi);


  @override
  Widget build(BuildContext context) {
    final date = _absensi.checkIn != null ? DateFormat.yMMMMEEEEd().format(_absensi.checkIn!) : "Unkown";
    final checkInTime = _absensi.checkIn != null ? DateFormat.Hm().format(_absensi.checkIn!) : "-";
    final checkOutTime = _absensi.checkOut != null ? DateFormat.Hm().format(_absensi.checkOut!) : "-";
    final day = _absensi.checkIn != null ? DateFormat.EEEE().format(_absensi.checkIn!)[0] : "-";
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
                Text(date, style: TextStyle(
                    fontSize: 9.sp,

                )),
                Expanded(child: FittedBox(child: Text(day, style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: ThemeColors.primarySecond
                ),))),
                Text("Check In   $checkInTime", style: TextStyle(
                    fontSize: 9.sp
                )),
                Text("Check Out   $checkOutTime", style: TextStyle(
                    fontSize: 9.sp
                ))
              ],
            )
        ),
      ),
    );
  }
}