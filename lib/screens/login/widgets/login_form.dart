import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/screens/login/login_controller.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/white_button.dart';

class LoginForm extends StatelessWidget {

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Color.fromARGB(0, 255, 255, 255), width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.redAccent, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.redAccent, width: 1.0),
      ),
      labelStyle: TextStyle(
          color: Color.fromARGB(255,146, 144, 148)
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10)
    );
  }


  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return   Container(
      decoration: BoxDecoration(
          color: ThemeColors.primarySecond,
          boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32))
      ),
      padding: EdgeInsets.only(left: 32, right: 32, top: 48, bottom: 24),
      child: Form(
        key: loginController.form,
        child: Column(
          children: [
            Text("Sign In", style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold
            )),
            SizedBox(height: 32),
            Container(
                margin: EdgeInsets.only(left: 6),
                width: double.infinity,
                child: Text("Username", style: TextStyle(color: Colors.white.withOpacity(0.8)))
            ),
            SizedBox(height: 5),
            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 14),
              cursorColor: Colors.black,
              decoration: _inputDecoration(context),
              maxLines: 1,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(loginController.passwordFocus);
              },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Username has to be filled";
                return null;
              },
              onSaved: (value) {
                if(value != null) loginController.setUsername(value);
              },
            ),
            SizedBox(height: 48),
            Container(
                margin: EdgeInsets.only(left: 6),
                width: double.infinity,
                child: Text("Password ", style: TextStyle(color: Colors.white.withOpacity(0.7)))
            ),
            SizedBox(height: 5),
            GetBuilder<LoginController>(
              builder: (value) => TextFormField(
              focusNode: loginController.passwordFocus,
              obscureText: true,
                  maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: 14),
              cursorColor: Colors.black,
              textInputAction: TextInputAction.send,
              decoration: _inputDecoration(context),
              onFieldSubmitted: (_) {
                value.save();
              },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Password has to be filled";
                return null;
              },
              onSaved: (value) {
                if(value != null) loginController.setPassword(value);
              },
            ),
            ),
            SizedBox(height: 60),
            GetBuilder<LoginController>(
              builder: (value) => MainButton(onTap: () {
                value.save();
              }),
            )
          ],
        ),
      ),
    );
  }
}
