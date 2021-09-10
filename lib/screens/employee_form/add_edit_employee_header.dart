import 'package:flutter/material.dart';

class AddEditEmployeeHeader extends StatelessWidget {
  const AddEditEmployeeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset("assets/img/employee_form_illustration.png", fit: BoxFit.contain,),
          ),
        ],
      ),
    );
  }
}
