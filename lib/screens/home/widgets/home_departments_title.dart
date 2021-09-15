import 'package:flutter/material.dart';
import 'package:movie_app/screens/department_list/department_list_screen.dart';
import 'package:movie_app/util/color.dart';


import 'package:sizer/sizer.dart';

class HomeDepartmentTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Department List", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp
              ),),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DepartmentListScreen.routeName);
                },
                child: Text("More Department", style: TextStyle(
                    color: ThemeColors.primaryThird,
                    fontSize: 10.sp
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}