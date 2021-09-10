import 'package:flutter/material.dart';
import 'package:movie_app/datasource/cache/service/UserDao.dart';
import 'package:movie_app/screens/absensi/absensi_screen.dart';
import 'package:movie_app/screens/login/login_screen.dart';
import 'package:movie_app/util/color.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  _showLogoutConfirmation(BuildContext context) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      backgroundColor: ThemeColors.primarySecond,
      content: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/img/logout_dialog.gif", fit: BoxFit.contain,  width: 100,
                height: 100),
            SizedBox(height: 20),
            Text("Are you sure to logout ?", style: TextStyle(color: ThemeColors.accentColor),),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async{
                  await UserDao().logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent
                ),
                child: Text("Yes", style: TextStyle(color: ThemeColors.accentColor))
            )
          ],
        ),
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.primarySecond,
      child: ListView(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: ThemeColors.primaryThird,
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Text("A"),
                    backgroundColor: Colors.green,
                  ),
                  Text("Admin")
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _showLogoutConfirmation(context);
                // Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
              },
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.white,),
                title: Text("Logout", style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, AbsensiScreen.routeName);
            // Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
          },
          child: ListTile(
            leading: Icon(Icons.qr_code, color: Colors.white,),
            title: Text("Absensi", style: TextStyle(color: Colors.white),),
          ),
        ),
      )
        ],
      ),
    );
  }
}
