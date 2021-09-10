import 'package:flutter/material.dart';
import 'package:movie_app/models/department.dart';
import 'package:movie_app/provider/provider_state.dart';
import 'package:movie_app/repository/department_repository.dart';

class DepartmentProvider with ChangeNotifier {

  final _departmentList = [];
  final _departmentRepo = DepartmentRepository();

  var _isFetchingDepartment = false;
  var _shouldLogout = false;


  var _currentState = ProviderState.Idle;
  String? _searchKey;


  List<Department> get departmentList {
    return [..._departmentList];
  }

  bool get isFetching {
    return _isFetchingDepartment;
  }

  ProviderState get currentState {
    return _currentState;
  }

  List<Department> get twoTopDepartments {
    final length = _departmentList.length;
    if(length >=2) {
      return [_departmentList[0], _departmentList[1]];
    }else if(length == 1){
      return [_departmentList[0]];
    }else{
      return [];
    }
  }

  void getDepartmentList({String? searchKey, bool shouldResetSearchKey = false}) async {
    _isFetchingDepartment = true;
    _currentState = ProviderState.Loading;
    _departmentList.clear();
    if(shouldResetSearchKey) {
      _searchKey = null;
    }else if(searchKey != null){
      _searchKey = searchKey;
    }
    notifyListeners();
    final fetch = await _departmentRepo.getAllDepartmentAndEmployees();
    fetch.whenWithResult(
        success: (value) {
          _isFetchingDepartment = false;
          _departmentList.clear();
          final filteredDepartment = _searchKey == null  ? value.data : value.data.where((element) => element.name.toLowerCase().contains(_searchKey!.toLowerCase())).toList();
          _currentState = ProviderState.Idle;
          _departmentList.addAll(filteredDepartment);
        },
        error: (value) {
          _currentState = ProviderState.Error;
          _isFetchingDepartment = false;
        },
        notAuthorize: (value) {
          _currentState = ProviderState.NotAuthorize;
          _isFetchingDepartment = false;
          _shouldLogout = true;
        }
    );
    notifyListeners();
  }

}