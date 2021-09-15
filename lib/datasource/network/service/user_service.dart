import 'dart:convert';

import 'package:movie_app/datasource/network/mapper/user_mapper.dart';
import 'package:movie_app/datasource/network/models/user_dto.dart';
import 'package:movie_app/datasource/network/network_const.dart';
import 'package:movie_app/models/user.dart';

import '../error_extractor.dart';
import '../rpc_client.dart';


class UserService {



  final _httpClient = ClientWithLogger();
  final _mapper = UserMapper();

  Future<User> getUserProfile(String sessionId) async {
    try{
      final url = Uri.parse("${NetworkConst.baseURL}/api/employee/");
      final response = await _httpClient.getWithCookie(url, sessionId);
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      if(response.statusCode == 200){
        return _mapper.mapToDomain(UserDto.fromJson(body));
      }else{
        throw ApiError.createError(body);
      }
    }catch(error){
      print(error);
      throw error;
    }
  }


  Future<String> login(String username, String password) async {
    try {
      print("Mencoba login dengan $username dan $password");
      var url = Uri.parse('${NetworkConst.baseURL}/web/session/authenticate');
      var client = RPCClient();
      var response = await client.post(
        url,
        body: jsonEncode({
          "db": NetworkConst.databaseName,
          "login": username,
          "password": password
        }),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        if (body.containsKey("result") && response.headers.containsKey("set-cookie")) {
          return response.headers["set-cookie"].toString().split(";")[0];
        } else {
          return body["error"]["data"]["message"] == "Access Denied"
              ? throw Exception("Username atau password salah")
              : throw Exception("Anda gagal melakukan login");
        }
      }
      throw Exception("Gagal login");
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
