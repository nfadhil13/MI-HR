import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/repository/user_repository.dart';
import 'package:movie_app/screens/department_list/department_list_screen.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'package:movie_app/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static final routeName = "/";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final userRepository =  UserRepository();

  @override
  void initState() {
    super.initState();
    checkLastLoggedInUser();
  }

  void checkLastLoggedInUser() async{
    (await userRepository.getLastLoggedInSessionId()).whenWithResult(
      success: (value) {
        Get.offNamed(HomeScreen.routeName);
      },
      notAuthorize: (dynamic) {
        Get.offNamed(LoginScreen.routeName);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image.asset("assets/img/login_illustration.gif", fit: BoxFit.contain)
        ),
      ),
    );
  }
}
