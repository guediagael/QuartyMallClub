import 'dart:async';
import 'dart:convert';

//import 'package:http/http.dart' as http;
import 'package:quarty_mall_club/string_resources.dart';
import 'package:dio/dio.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();

  static const String HEADER_ACCEPT_KEY = 'Accept';
  static const String AUTHORIZATION_KEY = 'Authorization';
  static const String CONTENT_TYPE_KEY = 'Content-Type';
  static const String HEADER_ACCEPT_VALUE_ALL = '*/*';
  static const String HEADER_VALUE_APPLICATION_URL_ENCODED = 'application/x-www-form-urlencoded';
  static const String HEADER_CACHE_CONTROL_KEY = 'Cache-Control';
  static const String HEADER_CACHE_CONTROL_VALUE_NO_CACHE = 'no-cache';
  static const String RESPONSE_STATUS_CODE = "response_status_code";
  static const String RESPONSE_DATA = "response_data";
  static const String RAW_RESPONSE = "raw_response";


  factory NetworkUtil()=>_instance;
  Function _errorCallback;

  Dio _dio;
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> postData(String url,Map<String,dynamic> data,
      Function onErrorCallback, {Map<String, dynamic> header = null}) {
    FormData formData = FormData.from(data);
    _errorCallback = onErrorCallback;
    _dio = Dio();
    return _dio.post(url,data: formData,options: Options(
      headers: header
    )).then((response){
      print("raw response $response");
      var statusCode = response.statusCode;
      print("response status code: $statusCode");
      if(statusCode < 200 || statusCode > 400) {
        onErrorCallback({
          RESPONSE_STATUS_CODE:statusCode,
          RESPONSE_DATA: response.data});
        return null;
      }
      return response.data;
//      return _decoder.convert(response.data);
    },onError: onError);
  }

  Future<dynamic> getData(String url,Map<String,dynamic> data,
      Function onErrorCallback, {Map<String, dynamic> header = null}){
    if(_dio == null) _dio = Dio();
    return _dio.get(url, options: Options(headers: header)).then((response){
      print("raw response $response");
      var statusCode = response.statusCode;
      print("response status code: $statusCode");
      if(statusCode < 200 || statusCode > 400) {
        onErrorCallback({
          RESPONSE_STATUS_CODE:statusCode,
          RESPONSE_DATA: response.data});
        return null;
      }
      return response.data;
    },onError: onError);
  }

  onError(dynamic error){
    if(error.runtimeType == DioError){
      DioError dioError = error;
      print("dio error: ${dioError.error}");
      print("dio errorType: ${dioError.type}");
      print("message: ${dioError.message}");
      print("response: ${dioError.response}");
      print("request: ${dioError.request}");
      print("stack trace: ${dioError.stackTrace}");
      _errorCallback({
        RESPONSE_STATUS_CODE:dioError.response.statusCode,
        RESPONSE_DATA: dioError.response.data});
    }else{
      print("framework error: $error");
      _errorCallback(
        RAW_RESPONSE: error
      );
    }

  }
}
