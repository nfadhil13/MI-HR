import 'package:flutter/material.dart';
import 'package:movie_app/provider/department_provider.dart';
import 'package:movie_app/util/color.dart';
import 'package:provider/provider.dart';

class DepartmentListSearchSection extends StatefulWidget {
  const DepartmentListSearchSection({Key? key}) : super(key: key);

  @override
  _DepartmentListSearchSectionState createState() => _DepartmentListSearchSectionState();
}

class _DepartmentListSearchSectionState extends State<DepartmentListSearchSection> {

  InputDecoration _inputDecoration() {
    return InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(0, 255, 255, 255), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Color.fromARGB(0, 255, 255, 255), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        labelStyle: TextStyle(
            color: Color.fromARGB(255,146, 144, 148)
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        prefixIcon: Icon(Icons.search, color: ThemeColors.primaryOne),
        hintText: "Seach department here!",
        hintStyle: TextStyle(
          fontSize: 14
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextFormField(
          maxLines: 1,
          cursorColor: ThemeColors.primaryOne,
          decoration: _inputDecoration(),
          style: TextStyle(
            fontSize: 14
          ),
          textInputAction: TextInputAction.send,
          onChanged: (value){
            Provider.of<DepartmentProvider>(context, listen: false).getDepartmentList(searchKey: value, shouldResetSearchKey: false);
          },
        )),
        SizedBox(width: 20),
        Container(
          child: Icon(Icons.more_horiz, color: Colors.white, size: 32,),
        )
      ],
    );
  }
}
