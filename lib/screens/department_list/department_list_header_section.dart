import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepartmentListHeaderSection extends StatelessWidget {
  const DepartmentListHeaderSection({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Our", style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold
        )),
        Text("Deparments", style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold
        )),
        SizedBox(height: 10),
        Text("We develop our company with such love", style: TextStyle(
          color: Colors.black.withOpacity(0.8)
        ),)
      ]
    );
  }
}
