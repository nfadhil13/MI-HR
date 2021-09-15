import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/screens/absensi_history/absensi_history_controller.dart';
import 'package:movie_app/util/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:sizer/sizer.dart';

class AbsensiCalendarSection extends StatelessWidget {
  const AbsensiCalendarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final absensiController = Get.find<AbsensiHistoryController>();
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 50.h,
      child: SfCalendar(
        backgroundColor: ThemeColors.accentColor ,
        todayTextStyle: TextStyle(color: ThemeColors.accentColor),
        todayHighlightColor: ThemeColors.primarySecond,
        headerStyle: CalendarHeaderStyle(
          textStyle: TextStyle(
              color: ThemeColors.primarySecond,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp
          ),

        ),
        initialSelectedDate: DateTime.now(),
        headerHeight: 5.h,
        viewHeaderStyle: ViewHeaderStyle(
            backgroundColor: ThemeColors.primarySecond,
            dayTextStyle: TextStyle(
                color: ThemeColors.accentColor
            )
        ),
        view: CalendarView.month,
        firstDayOfWeek: 1,
        onTap: (calendarTopDetails) {
          final selectedDate = calendarTopDetails.date;
          if(selectedDate != null){
              absensiController.setDate(selectedDate);
          }
        },
      ),
    );
  }
}
