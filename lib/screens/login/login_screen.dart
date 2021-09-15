import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/repository/user_repository.dart';
import 'package:movie_app/screens/login/login_controller.dart';
import 'package:movie_app/screens/login/widgets/login_form.dart';
import 'package:movie_app/screens/login/widgets/login_header.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/white_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  static final routeName = "/login-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ThemeColors.primaryThird,
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (value) => Container(
          child: LayoutBuilder(builder: (ctx, contraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: contraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: LoginHeader()),
                        LoginForm()
                      ],
                    ),
                  ),
                ),
                if(value.isFetching)  Positioned.fill(child: Container(
                  color: Colors.black45,
                  child: Center(child: CircularProgressIndicator()),
                ))
              ],
            );
          }),
        ),
      ),
    );
  }
}



