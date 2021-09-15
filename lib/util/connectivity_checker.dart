import 'dart:convert';

import 'package:movie_app/datasource/network/network_const.dart';
import 'package:movie_app/datasource/network/rpc_client.dart';

class ConnectivityChecker {


  final _rpcClient = RPCClient();

  Future<bool> isConnectionExist() async{
    try{
      var url = Uri.parse('${NetworkConst.baseURL}/web/session/authenticate');
      var response = await _rpcClient.post(
        url,
        body: jsonEncode({
          "db": NetworkConst.databaseName,
          "login": "",
          "password": ""
        }),
      );
      return true;
    }catch(error){
      return false;
    }
  }


  Future<T> connectivityCall<T>(
        Future<T> Function() onConnectivityExist,
        Future<T> Function() onConnectivityNotExist
      ) async{
    final isExist = await isConnectionExist();
    if(isExist){
      return await onConnectivityExist();
    }else{
      return await onConnectivityNotExist();
    }
  }

}