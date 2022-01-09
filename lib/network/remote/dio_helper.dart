
// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {

  static  Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response>  getData({
    @required String url,
     Map<String,dynamic> query,
    String lang="ar",
    String token,
  }) async
  {
    dio.options.headers=
    { "lang":lang,
      "Authorization":token??"",
      'Content-Type':'application/json'};
    return await dio.get(url,queryParameters: query);
  }
  static Future<Response>  postData({
    @required String url,
    Map<String,dynamic> query,
    @required Map<String,dynamic> data,
    String lang="ar",
    String token,
  }) async{
    dio.options.headers=
    {  "lang":lang,
       "Authorization":token??"",
      'Content-Type':'application/json'};
    return await dio.post(url,queryParameters: query,data: data);
  }
}