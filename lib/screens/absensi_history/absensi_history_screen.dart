import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/screens/absensi_history/widgets/absensi_calendar_section.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/responsive_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:sizer/sizer.dart';

class AbsensiHistoryScreen extends StatelessWidget {
  const AbsensiHistoryScreen({Key? key}) : super(key: key);

  static final routeName = "/absensi-history-screen";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.accentColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ThemeColors.accentColor,
            iconTheme: IconThemeData(color: ThemeColors.primaryOne),
          ),
          ResponsiveWidget(
              portrait: SliverList(delegate: SliverChildListDelegate.fixed([
                Text("${100.h} vs ${100.sp} vs ${MediaQuery.of(context).size.height} potrait ${SizerUtil.orientation}")
              ]),) ,
              landscape: SliverList(delegate: SliverChildListDelegate.fixed([
                Text("${100.h} vs ${100.sp} vs ${MediaQuery.of(context).size.height} landscape ${SizerUtil.orientation}")
              ]),)
          )
        ]
      ),
    );
  }
}
