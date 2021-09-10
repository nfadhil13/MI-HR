import 'dart:convert';
import 'dart:io';

import 'package:movie_app/datasource/JSONParser.dart';
import 'package:movie_app/datasource/network/error_extractor.dart';
import 'package:movie_app/datasource/network/mapper/absensi_mapper.dart';
import 'package:movie_app/datasource/network/models/absensi_dto.dart';
import 'package:movie_app/datasource/network/rpc_client.dart';
import 'package:movie_app/models/absensi.dart';

import '../network_const.dart';

class AbsensiService {

  static final _absensiExtraURL = "/api/attendance";


  final _client = ClientWithLogger();
  final _absensiMapper = AbsensiMapper();

  Uri _constructURL(String endPoint){
    return Uri.parse(NetworkConst.baseURL + _absensiExtraURL + endPoint);
  }

  Future<List<Absensi>> getAbsensiOfUser(String sessionId) async{
    try{
      print("MASUK");
      final result =await _client.getWithCookie(_constructURL(""), sessionId);
      print("berhasil dengan");
      print(result.body);
      if(result.statusCode == 200){
        final responseBody = jsonDecode(result.body) as List;
        return responseBody.map((e) => _absensiMapper.mapToDomain(AbsensiDto.fromJson(e))).toList();
      }else{
        final responseBody = jsonDecode(result.body) as Map<String, dynamic>;
        throw ApiError.createError(responseBody);
      }
    }catch(err){
      print(err);
      throw(err);
    }
  }

  Future<void> checkIn(String sessionId, double latitude , double longitude) async {
    try{
      final result =await _client.postWithCookie(_constructURL("/check_in"), sessionId, body: jsonEncode({
        "lat_in" : latitude,
        "long_in" : longitude,
        "body_temp" : 300.0
      }));
      print("berhasil!!!");
      print(result.body);
      final responseBody = jsonDecode(result.body) as Map<String,dynamic>;
      if(result.statusCode != 200){
        throw ApiError.createError(responseBody);
      }
    }catch(err){
      print(err);
      throw(err);
    }
  }

  Future<void> checkOut(String sessionId, double latitude , double longitude) async {
    try{
      final result =await _client.postWithCookie(_constructURL("/check_out"), sessionId, body: jsonEncode({
        "lat_out" : latitude,
        "long_out" : longitude
      }));
      print(result.body);
      final responseBody = jsonDecode(result.body) as Map<String,dynamic>;
      print("kalo error ${SafeCaster.tryCastAndDefault(responseBody["code"], -1)}");
      if(result.statusCode != 200 || SafeCaster.tryCastAndDefault(responseBody["code"], -1) == 202){
        print("error 202 dong");
        throw ApiError.createError(responseBody);
      }
    }catch(err){
      print(err);
      throw(err);
    }
  }


}