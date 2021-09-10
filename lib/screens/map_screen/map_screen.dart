import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_app/models/location_data.dart';
import 'package:movie_app/provider/absensi_provider.dart';
import 'package:movie_app/screens/map_screen/map_bottom_sheet.dart';
import 'package:movie_app/util/color.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:movie_app/provider/provider_state.dart';


class MapScreen extends StatefulWidget {

  final LocationData _location;


  final  _markers = HashSet<Marker>();
  static final routeName = "/map-screen";

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.200000, 106.816666),
    zoom: 14.4746,
  );

  late final CameraPosition _currentUserPosition;

  MapScreen(this._location){
    _currentUserPosition =  CameraPosition(
        bearing: 0,
        target: _location.location,
        tilt: 0,
        zoom: 19.151926040649414);
    _markers.add(Marker(
      markerId: MarkerId("current_user_positin"),
      position: _location.location
    ));
  }

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();


  Widget _buildBackButton() {
    return Container(
        padding: EdgeInsets.only(top: 16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Icon(Icons.arrow_back_ios_outlined, color: ThemeColors.primaryOne,),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            padding: MaterialStateProperty.all(EdgeInsets.all(1.h)),
            backgroundColor: MaterialStateProperty.all(Colors.white), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) return ThemeColors.primaryThird; // <-- Splash color
            }),
          ),
        )
    );
  }

  Widget _buildGotoMyLocationButton() {
    return Container(
        padding: EdgeInsets.only(top: 16),
        child: ElevatedButton(
          onPressed: () async{
            final controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(widget._currentUserPosition));
          },
          child: Icon(Icons.location_searching_sharp, color: ThemeColors.primaryOne,),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            padding: MaterialStateProperty.all(EdgeInsets.all(1.h)),
            backgroundColor: MaterialStateProperty.all(Colors.white), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) return ThemeColors.primaryThird; // <-- Splash color
            }),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: MapScreen._kGooglePlex,
            onMapCreated: (GoogleMapController controller) async{
              _controller.complete(controller);
              controller.animateCamera(CameraUpdate.newCameraPosition(widget._currentUserPosition));
            },
            markers: widget._markers,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _buildBackButton()
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildGotoMyLocationButton(),
                SizedBox(height: 1.5.h),
                MapBottomSheet(widget._location)
              ],
            ),
          ),
          Positioned.fill(
            child: Consumer<AbsensiProvider>(
              builder: (_, provider, __){
                print("Ada notify woy");
                return provider.currentState.when<Widget?>(
                  onLoading: () {
                    return Container(
                      color: Colors.black.withOpacity(0.25),
                      child: Center(
                        child: CircularProgressIndicator(),
                      )
                    );
                  },
                  onError: () {
                    final errorMessage = provider.errorMessage;
                    print("Error dengan error message $errorMessage");
                    if(errorMessage != null){
                      _showScaffold(errorMessage);
                    }
                  },
                  onIdle: () {
                    final isFetchingDone = provider.isAttendanceFetchDone;
                    if(isFetchingDone != null){
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        Navigator.pop(context, true);
                      });
                    }
                  }
                ) ?? SizedBox();
              }
            ),
          )
        ],
      )
    );
  }

  void _showScaffold(String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
        content: Container(
          color: Colors.redAccent,
          child: Text(message, style: TextStyle(color: Colors.white)),
        ),
      ));
    });

  }
}