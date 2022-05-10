import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:artivatic_flutterassignment/Models/ResponseModel.dart';
import 'package:artivatic_flutterassignment/Utils/CommonUtils.dart';
import 'package:artivatic_flutterassignment/Utils/MessageLogger.dart';
import 'package:artivatic_flutterassignment/Utils/StringUtil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'AppInterceptors.dart';

class DioClient {
  static Dio? _dio;
  static DioClient? _client;

  static DioClient? getinstance() {
    _client = new DioClient();
    return _client;
  }

  DioClient() {
    _dio = Dio();
    _dio?.options.baseUrl = "https://run.mocky.io/v3/";
    _dio?.options.connectTimeout = 120000; // 120 secs
    _dio?.options.receiveTimeout = 120000; // 120 secs
    _dio?.options.sendTimeout = 120000; // 120 secs
    _dio?.options.contentType = Headers.jsonContentType;
    _dio?.interceptors.add(LogInterceptor(
        request: !kReleaseMode,
        requestBody: !kReleaseMode,
        responseBody: !kReleaseMode));
    _dio?.interceptors.addAll({
      AppInterceptors(_dio!),
    });
  }

  Future<ResponseModel?> getHTTP(String url) async {
    try {
      Response? response = await _dio?.get(url);

      if (response?.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response?.data);
        return responseModel;
      } else {
        CommonUtils.showToast(response?.data);
      }
    } on DioError catch (e) {
      // Handle error
      MessageLogger.logmsg(e.message);
      if (StringUtil.CheckifStringContains(e.toString(), 'internet')) {
        CommonUtils.showToast(e.toString());
      }
    }
  }

  Future<Response?> postHTTP(String url, dynamic data) async {
    try {
      Response? response = await _dio?.post(
        url,
        data: data,
      );
      return response;
    } on DioError catch (e) {
      // Handle error
      if (StringUtil.CheckifStringContains(e.toString(), 'internet')) {
        CommonUtils.showToast(e.toString());
      }
    }
  }

  Future<Response?> putHTTP(String url, dynamic data) async {
    try {
      Response? response = await _dio?.put(url, data: data);
      return response;
    } on DioError catch (e) {
      if (StringUtil.CheckifStringContains(e.toString(), 'internet')) {
        CommonUtils.showToast(e.toString());
      }
    }
  }

  Future<Response?> deleteHTTP(String url) async {
    try {
      Response? response = await _dio?.delete(url);
      return response;
    } on DioError catch (e) {
      // Handle error
      if (StringUtil.CheckifStringContains(e.toString(), 'internet')) {
        CommonUtils.showToast(e.toString());
      }
    }
  }
}
