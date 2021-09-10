import 'package:flutter/material.dart';
import 'package:movie_app/models/location_data.dart';
import 'package:movie_app/provider/absensi_provider.dart';
import 'package:movie_app/util/color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MapBottomSheet extends StatelessWidget {

  final LocationData _location;

  MapBottomSheet(this._location);

  Widget _buildBottomSheetMain() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.h),
      width: double.infinity,
      height: 32.h,
      decoration: BoxDecoration(
          color: ThemeColors.accentColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "We Found You!",
            style: TextStyle(
                color: ThemeColors.primarySecond,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp),
          ),
          Text(_location.address,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: ThemeColors.primarySecond, fontSize: 12.sp)),
          Consumer<AbsensiProvider>(
            builder: (_, provider, ___){
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ThemeColors.primarySecond,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    if(provider.shouldCheckIn()){
                      provider.checkIn(_location.location.latitude, _location.location.latitude);
                    }else{
                      provider.checkOut(_location.location.latitude, _location.location.latitude);
                    }
                  },
                  child: Container(width: 50.w, child: Text(
                    provider.shouldCheckIn() ? "Check In" : "Check Out"
                  ), alignment: Alignment.center,));
            }
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min, children: [_buildBottomSheetMain()]),
    );
  }
}
