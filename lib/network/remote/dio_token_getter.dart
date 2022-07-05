import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioTokenGetter
{
  static String dummyBaseUrl = "https://sandbox-authservice.priaid.ch/";
  static String realBaseUrl = "https://authservice.priaid.ch/";
  static String dummyBearer = "Bearer maroelshamloul@hotmail.com:IaCxVFbNAK3fzNL11SUHkw==";
  static String realBearer = "Bearer z3XJk_HOTMAIL_COM_AUT:VaOGS7wKF7lVD7vl0h5w4A==";
  static String token = "";
  static Dio dio;
  static init()
  {
    dio = Dio(
        BaseOptions(
          baseUrl: realBaseUrl,
          receiveDataWhenStatusError: true,
          headers: {
            "format" : "json",
            "Authorization" : realBearer,
          },
        )
    );
  }
  static Future<Response> postData({
    @required String url,
    Map<String,dynamic> query,
    @required Map<String,dynamic> data,
  })
  async {
    return await dio.post(
        url,
        data: data);
  }
  static void getToken()
  {
    postData(url: "login", data: {"data":"dummy"}).then((value)
    {
      token = value.data['Token'];
      print("Token initialized : "+token);
    }).catchError((error){
      print(error.toString());
    });
  }
}