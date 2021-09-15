import 'dart:convert';

import 'package:http/http.dart' as http;

class RPCClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    print("Request URL : ${request.url}");
    if (request is http.Request) {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      request.body = jsonEncode({"jsonrpc": "2.0", "params": body});
      request.headers.addAll({"content-type"  : "application/json"});
      print(request.body);
    }
    if (request is http.Response){
      print("Response :");
    }
    return request.send();
  }
}

class ClientWithLogger extends http.BaseClient {




  Future<http.Response> postWithCookie(Uri url, String cookieValue, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    final finalHeader = headers != null ? headers : Map<String, String>();
    finalHeader.addAll(
        {
          "content-type"  : "application/json",
          "Cookie" : cookieValue
        }
    );
    return this.post(url,
        headers:  finalHeader,
        body : body,
        encoding: encoding
    );
  }



  Future<http.Response> getWithCookie(Uri url, String cookieValue, {Map<String, String>? headers}) async{
    final finalHeader = headers != null ? headers : Map<String, String>();
    finalHeader.addAll(
        {
          "cookie" : cookieValue
        }
    );
    final result = await this.get(url, headers: finalHeader);
    print("====Result dari get===");
    print(result.body);
    return result;
  }




  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    print("Request URL : ${request.url}");
    print("=======Header======");
    request.headers.forEach((key, value) {
      print("$key:$value");
    });
    if (request is http.Request) {
      if(request.method == "POST" || request.method == "PUT"){
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        print("====Body=====");
        body.forEach((key, value) {
          print("$key $value");
        });
        // request.headers.addAll({"content-type"  : "application/json"});
      }
    }
    return request.send();
  }

}