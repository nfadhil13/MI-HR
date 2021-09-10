import 'dart:collection';

class ApiError extends Error {

  final String errorMessage;

  ApiError(this.errorMessage);

  static ApiError createError(Map<String, dynamic> responseBody){
    print("coba mengekstrak error");
    if(responseBody.containsKey("description")){
      return ApiError(responseBody["description"].toString());
    }
    if(responseBody.containsKey("message")){
      print(responseBody["message"]);
      return ApiError(responseBody["message"].toString());
    }
    print("tidak memiliki body meessage");
    return ApiError("Unknown Error on the server");
  }
  
}