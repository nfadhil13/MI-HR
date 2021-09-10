import 'package:flutter/material.dart';
import 'package:movie_app/repository/user_repository.dart';
import 'package:movie_app/screens/department_list/department_list_screen.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/white_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  GlobalKey buttonKey = GlobalKey();

  var _username = "";
  var _password = "";

  var userRepository = UserRepository();

  final _passwordFocus = FocusNode();

  final _form = GlobalKey<FormState>();


  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocus.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration() {
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

  void save() async {
    final currentState = _form.currentState;
    print(currentState);
    if (currentState != null && currentState.validate()) {
      currentState.save();
      final result = await userRepository.login(_username, _password);
      result.whenWithResult(
              success: (value) {
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              },
              error: (value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Container(
                child: Text(value.message, style: TextStyle(
                    color: Colors.white
                )),
              ),
            ));
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        key: _form,
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
              decoration: _inputDecoration(),
              maxLines: 1,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Username has to be filled";
                return null;
              },
              onSaved: (value) {
                _username = value ?? _username;
              },
            ),
            SizedBox(height: 48),
            Container(
                margin: EdgeInsets.only(left: 6),
                width: double.infinity,
                child: Text("Password ", style: TextStyle(color: Colors.white.withOpacity(0.7)))
            ),
            SizedBox(height: 5),
            TextFormField(
              focusNode: _passwordFocus,
              obscureText: true,
              maxLines: 1,
              style: TextStyle(color: Colors.black, fontSize: 14),
              cursorColor: Colors.black,
              textInputAction: TextInputAction.send,
              decoration: _inputDecoration( ),
              onFieldSubmitted: (_) {
                save();
              },
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Password has to be filled";
                return null;
              },
              onSaved: (value) {
                _password = value ?? _password;
              },
            ),
            SizedBox(height: 60),
            MainButton(onTap: () {
              print("Halo halo");
              save();
            })
          ],
        ),
      ),
    );
  }
}
