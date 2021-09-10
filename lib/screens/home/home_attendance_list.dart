import 'package:flutter/material.dart';
import 'package:movie_app/screens/home/attendance_home_item.dart';
import 'package:sizer/sizer.dart';
class HomeAttendanceList extends StatefulWidget {
  const HomeAttendanceList({Key? key}) : super(key: key);

  @override
  _HomeAttendanceListState createState() => _HomeAttendanceListState();
}

class _HomeAttendanceListState extends State<HomeAttendanceList> {
  @override
  Widget build(BuildContext context) {
    return  SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 8),
        height: 20.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx , index) => AttendanceHomeItem(),
          itemCount: 10,
        ),
      ),
    );
  }
}
