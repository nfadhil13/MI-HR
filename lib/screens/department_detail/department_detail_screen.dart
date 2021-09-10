import 'package:flutter/material.dart';
import 'package:movie_app/models/department.dart';
import 'package:movie_app/util/color.dart';
import 'package:movie_app/widgets/employee_grid_item.dart';

class DepartmentDetailScreen extends StatelessWidget {
  final Department _department;

  static final routeName = "/department-detail-screen";

  DepartmentDetailScreen(this._department);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          flexibleSpace: Container(
            child : Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                      "https://www.linovhr.com/wp-content/uploads/2021/02/meeting.jpg", fit: BoxFit.cover),
                ),
                Container(
                  child: Text(_department.name),
                ),
                Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
        SliverList(delegate: SliverChildListDelegate.fixed(
          [
            Container(
              padding: EdgeInsets.only(left: 18, right: 18,top: 24),
              child: Text("Description", style: TextStyle(color: ThemeColors.primarySecond, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.all(18),
              child: Text(_department.description, style: TextStyle(color: ThemeColors.primarySecond.withOpacity(0.9))),
            ),
            SizedBox(height: 48),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text("Employees",  style: TextStyle(color: ThemeColors.primarySecond, fontWeight: FontWeight.bold))
            ),
            SizedBox(height: 24),
          ]
        )),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
          ),
          delegate: SliverChildBuilderDelegate(
              (_, index) => Padding(
                padding: const EdgeInsets.all(16),
                child: EmployeeGridItem(_department.employees[index]),
              ),
            childCount: _department.employees.length
          ),
        )
      ],
    ));
  }
}
