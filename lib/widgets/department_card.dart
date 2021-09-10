import 'package:flutter/material.dart';
import 'package:movie_app/models/department.dart';
import 'package:movie_app/util/color.dart';

class DepartmentCard extends StatelessWidget {

  final Department _department;
  final int _index;
  final Function _onTap;

  DepartmentCard(this._department, this._index,  this._onTap);

  final _backgroundColor = [
    ThemeColors.primarySecond,
    ThemeColors.secondaryColor,
    ThemeColors.primaryOne
  ];

  final _textColor = [
    ThemeColors.accentColor,
    ThemeColors.primarySecond,
    ThemeColors.accentColor
  ];

  @override
  Widget build(BuildContext context) {
    final colorIndex = _index % 3;
    return InkWell(
      onTap: () {
        _onTap();
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        color: _backgroundColor[colorIndex],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(_department.name[0], style: TextStyle(color: _backgroundColor[colorIndex]),),
              backgroundColor: _textColor[colorIndex],
            ),
            title: Text( _department.name, style: TextStyle(color: _textColor[colorIndex], fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1,),
            subtitle: Text(
                _department.description, style: TextStyle(color: _textColor[colorIndex].withOpacity(0.5), fontWeight: FontWeight.w500, fontSize: 12), maxLines: 2,)
          ),
        ),
      ),
    );
  }
}
