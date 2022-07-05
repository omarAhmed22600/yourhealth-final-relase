import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper
{
  static String realBaseUrl = "https://healthservice.priaid.ch/";
  static String dummyBaseUrl = "https://sandbox-healthservice.priaid.ch/";
  static Dio dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: realBaseUrl,
        receiveDataWhenStatusError: true,
      )
    );
  }
  static Future<Response> getData({
  @required String url,
    @required Map<String,dynamic> query,
  })
  async {
    return await dio.get(url,queryParameters: query);
  }
}