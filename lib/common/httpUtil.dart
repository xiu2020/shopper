import 'package:dio/dio.dart';


class ApiManager {
  Dio dio = Dio();

  ApiManager() {
    dio.options.baseUrl = 'http://172.24.110.18:2000'; // 设置默认的基本 URL
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 10);
  }

  void setConnectTimeout(int seconds) {
    dio.options.connectTimeout = Duration(seconds: seconds);
    return;
  }

  String getBaseUrl() {
    return dio.options.baseUrl;
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.post(path, data: data);
      return response;
    } catch (e) {
      print('Error occurred: $e');
      throw e; // 抛出异常供调用方处理
    }
  }

// 可以添加其他常用的网络请求方法，如 get、put、delete 等
  Future<Response> get(String path, {Map<String, dynamic>? data}) async {
    try {
      Response response = await dio.get(path, queryParameters: data);
      return response; //response.data.toString()
    } catch (e) {
      print('Error occurred: $e');
      throw e; // 抛出异常供调用方处理
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data, Map<String, dynamic>? query}) async {
    try {
      Response response = await dio.delete(path, data:data, queryParameters: query);
      return response; //response.data.toString()
    } catch (e) {
      print('Error occurred: $e');
      throw e; // 抛出异常供调用方处理
    }
  }
}