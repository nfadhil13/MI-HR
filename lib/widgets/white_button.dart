import 'package:flutter/material.dart';
import 'package:movie_app/util/color.dart';

class MainButton extends StatelessWidget {

  final Function onTap;

  const MainButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        onTap()
      },
      child: Card(
        color: ThemeColors.primaryThird,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 14),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "Sign In",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            )),
      ),
    );
  }
}