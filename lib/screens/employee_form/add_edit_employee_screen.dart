import 'package:flutter/material.dart';
import 'package:movie_app/screens/employee_form/add_edit_employee_form.dart';
import 'package:movie_app/screens/employee_form/add_edit_employee_header.dart';

class AddEditEmployeeScreen extends StatelessWidget {
  const AddEditEmployeeScreen({Key? key}) : super(key: key);

  static final routeName = "/add-or-edit-employee";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor
        ),
        elevation: 0,
      ),
      backgroundColor:Theme.of(context).backgroundColor,
      body: Container(
        child: LayoutBuilder(builder: (ctx, contraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: contraints.maxHeight),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                      padding: const  EdgeInsets.only(
                          left: 32, right: 32, top: 24),
                      child: const AddEditEmployeeHeader()),
                  const AddEditEmployeeForm()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
