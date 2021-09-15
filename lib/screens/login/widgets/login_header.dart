

import 'package:flutter/material.dart';
import 'package:movie_app/util/color.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "MI - HR",
            style : TextStyle(
              color:  ThemeColors.accentColor,
              fontSize: 48,
              fontWeight: FontWeight.bold
            )
          ),
          SizedBox(height: 24),
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            child: Image.asset("assets/img/login_illustration.gif", fit: BoxFit.contain,),
          ),
        ],
      ),
    );
  }
}
