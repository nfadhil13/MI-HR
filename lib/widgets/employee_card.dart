import 'package:flutter/material.dart';
import 'package:movie_app/models/employee.dart';
import 'package:movie_app/models/employee.dart';

class EmployeeCard extends StatelessWidget {

  final Employee _employee;
  final int _index;

  EmployeeCard(this._employee,  this._index);

  final _colorList = [
    Color.fromARGB(255, 125, 164, 243),
    Color.fromARGB(255, 241, 167, 96),
    Color.fromARGB(255,234, 90, 120),
    Color.fromARGB(255,164, 125, 244),
    Color.fromARGB(255,104, 226, 188)
  ];

  int get _colorIndex {
    return _index % _colorList.length;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                _colorList[_colorIndex],
                _colorList[_colorIndex].withOpacity(0.6),
              ],
              stops: [
                0.0 , 1
              ]
          ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          )
        ]
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_employee.imageURL, headers: {
              'Cookie' : 'session_id=b2437cbc145f404b39fc01204fb3439f8b33d4eb'
            }),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(""),
            ),
          ),
          title: Text(_employee.name, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(_employee.position, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

