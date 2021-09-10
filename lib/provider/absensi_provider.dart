
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/absensi.dart';
import 'package:movie_app/provider/base_provider.dart';
import 'package:movie_app/provider/provider_state.dart';
import 'package:movie_app/repository/absensi_repository.dart';
import 'package:movie_app/util/single_event.dart';


class AbsensiProvider extends BaseProvider{

  final _absensiRepository = AbsensiRepository();

  final List<Absensi> _absensiList = [];


  SingleEvent<bool>? _isAttendanceFetchDone;

  AbsensiProvider() {
    getAbsensiList();
  }

  bool? get isAttendanceFetchDone {
    print("Iss fetching done ? ${_isAttendanceFetchDone?.peek}");
    return _isAttendanceFetchDone?.data;
  }

  List<Absensi> get absensiList {
    return [..._absensiList];
  }


  bool  shouldCheckIn() {
    if(_absensiList.isNotEmpty){
      final lastAbsensi = _absensiList.first;
      print("last absensi is null ${lastAbsensi.id} ${lastAbsensi.checkOut}");
      if(lastAbsensi.checkOut == null) {
        return false;
      }
      return true;
    }
    return true;
  }

  Absensi? lastAbsensi(){
    if(_absensiList.isNotEmpty){
      final lastAbsensi = _absensiList.first;
      if(lastAbsensi.checkOut == null) {
        return lastAbsensi;
      }
      return null;
    }
    return null;
  }

  void getAbsensiList() {
    fetch<List<Absensi>>(() => _absensiRepository.getAbsensiList(), (data) {
      print(data.length);
      _absensiList.addAll(data);
    }, beforeStart: () {
      _absensiList.clear();
    });

  }

  void checkIn(double latitude, double longitude){
    fetch(() => _absensiRepository.checkIn(latitude, longitude), (data) {
      _isAttendanceFetchDone = SingleEvent(true);
    }, onError: (message) {
      print("Error check in with message : $message");
    });
  }

  void checkOut(double latitude, double longitude){
    fetch(() => _absensiRepository.checkOut(latitude, longitude), (data) {
      _isAttendanceFetchDone = SingleEvent(true);
    },
      onError: (message){
        print("Error saat checkout: $message");
      }
    );
  }

}