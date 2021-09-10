import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_app/screens/map_screen/map_screen.dart';
import 'package:movie_app/util/location_helper.dart';
import 'package:movie_app/util/color.dart';
import 'package:sizer/sizer.dart';

class GettingLocationScreen extends StatefulWidget {
  const GettingLocationScreen({Key? key}) : super(key: key);

  static final routeName = "/getting-location-screen";

  @override
  _GettingLocationScreenState createState() => _GettingLocationScreenState();
}

class _GettingLocationScreenState extends State<GettingLocationScreen> {


  final _locationHelper = LocationHelper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _gettingLocation();
    });
  }

  void _gettingLocation() async {
    try{
      final locationResult = await _locationHelper.determinePosition();

      if(!locationResult.isMocked){
        Navigator.of(context).pushReplacementNamed(
            MapScreen.routeName,
            arguments: locationResult
        );
      }else{

      }
    } catch(err){
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.accentColor,
      body: Center(
        child: Container(
          height: SizerUtil.orientation == Orientation.portrait ? 45.h : 70.w,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Container(
                child: Image.asset("assets/img/getting_location.gif"),
              )),
              SizedBox(height: 2.h),
              Text("Getting Your Location ...", style: TextStyle(
                color: ThemeColors.primarySecond,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
