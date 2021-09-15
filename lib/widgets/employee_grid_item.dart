import 'package:flutter/material.dart';
import 'package:movie_app/datasource/cache/service/user_dao.dart';
import 'package:movie_app/models/employee.dart';

class EmployeeGridItem extends StatelessWidget {
  final Employee _employee;
  final UserDao _userDao = UserDao();

  Widget _buildLoadingImage() {
    return Container(
      color: Colors.black45,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  EmployeeGridItem(this._employee);
  @override
  Widget build(BuildContext context) {
    return Card(

      child: GridTile(
        child: FutureBuilder<String?>(
          future: _userDao.getLastLoginUserSession(),
          builder: (ctx, snapshot) {
            if(snapshot.hasData){
              if(snapshot.data != null){
                return Image.network(
                    _employee.imageURL,
                    headers: {
                      'Cookie' : snapshot.data!
                    },
                    errorBuilder:(_, __, ___)  {
                      print("Erroor");
                      return Text("Error");
                    },
                    fit: BoxFit.cover,
                );
              }else{
                _userDao.logout().then((value) => print("Logout"));
              }
            }
            if(snapshot.hasError){
              print(snapshot.error);
            }
            print("loading diluar");
            return _buildLoadingImage();
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            _employee.name
          ),
        ),
      ),
    );
  }
}
