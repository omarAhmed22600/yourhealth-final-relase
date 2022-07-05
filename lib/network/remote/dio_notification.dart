import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioNotificationHelper
{
  static String BaseUrl = 'https://fcm.googleapis.com/';
  static Dio dio;
  static String serverToken = "AAAAsvpDc80:APA91bFLgIkdF0_SEXUFmlVl0T5_Z9kgU5VnaTc_4zna8oSqz24RfAVIYT0dEZYkhWRjXEgb_5fjLRk3_ZHsZW_0UJTdrxgTU6HMaBungp2KUhggDDyxMgYxhVO_1EGuYZZXnrKO_mXI";
  static init()
  {
    dio = Dio(
        BaseOptions(
          baseUrl: BaseUrl,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverToken',
          },
        )
    );
  }
  static Future<Response> postData({
    Map<String,dynamic> query,
    @required Map<String,dynamic> data,
  })
  async {
    String url = "fcm/send";
    return await dio.post(
        url,
        data: data);
  }
}