import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/controller/absensi_global_controller.dart';
import 'package:movie_app/datasource/cache/hive_helper.dart';
import 'package:movie_app/datasource/cache/local_storage.dart';
import 'package:movie_app/models/department.dart';
import 'package:movie_app/models/location_data.dart';
import 'package:movie_app/provider/department_provider.dart';
import 'package:movie_app/screens/absensi_history/absensi_binding.dart';
import 'package:movie_app/screens/absensi_history/absensi_history_screen.dart';
import 'package:movie_app/screens/map_screen/map_binding.dart';
import 'package:movie_app/screens/absensi/absensi_screen.dart';
import 'package:movie_app/screens/department_detail/department_detail_screen.dart';
import 'package:movie_app/screens/department_list/department_list_screen.dart';
import 'package:movie_app/screens/employee_form/add_edit_employee_screen.dart';
import 'package:movie_app/screens/getting_location_screen/getting_location_screen.dart';
import 'package:movie_app/screens/home/home_binding.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'package:movie_app/screens/login/login_screen.dart';
import 'package:movie_app/screens/map_screen/map_screen.dart';
import 'package:movie_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await HiveHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => DepartmentProvider()),
      ],
      child: Sizer(
        builder: (_ , __ , ___) => GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Color.fromARGB(255,198,108,243),
                backgroundColor: Color.fromARGB(255,246,246,246),
                textTheme: TextTheme().apply(bodyColor: Colors.white, displayColor: Colors.white),
                fontFamily: 'Poppins'
            ),
            initialRoute: "/",
            getPages: [
              GetPage(name: SplashScreen.routeName, page:()  => SplashScreen()),
              GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
              GetPage(name: HomeScreen.routeName, page: () => HomeScreen(), binding: HomeBinding()),
              GetPage(name: GettingLocationScreen.routeName, page: () => GettingLocationScreen()),
              GetPage(name: MapScreen.routeName, page: () => MapScreen(Get.arguments as LocationData), binding: MapBinding()),
              GetPage(name: AbsensiHistoryScreen.routeName, page: () => AbsensiHistoryScreen(), binding: AbsensiBinding())
            ],
          )
      ),
    );
  }
}

