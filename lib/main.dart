import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_app/datasource/cache/local_storage.dart';
import 'package:movie_app/models/department.dart';
import 'package:movie_app/models/location_data.dart';
import 'package:movie_app/provider/absensi_provider.dart';
import 'package:movie_app/provider/department_provider.dart';
import 'package:movie_app/screens/absensi/absensi_screen.dart';
import 'package:movie_app/screens/department_detail/department_detail_screen.dart';
import 'package:movie_app/screens/department_list/department_list_screen.dart';
import 'package:movie_app/screens/employee_form/add_edit_employee_screen.dart';
import 'package:movie_app/screens/getting_location_screen/getting_location_screen.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'package:movie_app/screens/login/login_screen.dart';
import 'package:movie_app/screens/map_screen/map_screen.dart';
import 'package:movie_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => DepartmentProvider()),
        ChangeNotifierProvider(create: (ctx) => AbsensiProvider())
      ],
      child: Sizer(
        builder: (_ , __ , ___) => MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Color.fromARGB(255,198,108,243),
                backgroundColor: Color.fromARGB(255,246,246,246),
                textTheme: TextTheme().apply(bodyColor: Colors.white, displayColor: Colors.white),
                fontFamily: 'Poppins'
            ),
            home: SplashScreen(),
            routes: {
              HomeScreen.routeName: (ctx) => HomeScreen(),
              AbsensiScreen.routeName : (ctx) => AbsensiScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              AddEditEmployeeScreen.routeName : (ctx) => AddEditEmployeeScreen(),
              DepartmentListScreen.routeName : (ctx) => DepartmentListScreen(),
              DepartmentDetailScreen.routeName : (ctx) {
                final departmentData = ModalRoute.of(ctx)?.settings.arguments as Department;
                return DepartmentDetailScreen(departmentData);
              },
              GettingLocationScreen.routeName : (ctx)  => GettingLocationScreen(),
              MapScreen.routeName: (ctx) {
                final latlang = ModalRoute.of(ctx)?.settings.arguments as LocationData;
                return MapScreen(latlang);
              }
            },
          )
      ),
    );
  }
}

