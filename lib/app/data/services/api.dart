import 'dart:convert';

import 'package:authenticator_app/app/data/services/secure_storage.dart';
import 'package:authenticator_app/app/data/utils/variables.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: dotenv.env['API_OTP_BASE_URI'] ?? 'http://103.127.96.150:9000',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);

String error(DioException v) {
  switch (v.type) {
    case DioExceptionType.connectionTimeout:
      return AppVariable.rto;
    case DioExceptionType.badResponse:
      if (v.response != null) {
        return "${jsonDecode(v.response!.toString())['message']}";
      } else {
        return "${v.message}";
      }
    case DioExceptionType.unknown:
    case DioExceptionType.connectionError:
      return AppVariable.noInternet;
    default:
      return AppVariable.unknown;
  }
}

class Api {
  var box = SecureStorageService();
  Future<Response> postWithoutToken({String? path, Object? data}) async {
    try {
      final response = await dio.post(path!, data: data);
      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> postWithToken({String? path, Object? data}) async {
    var token = box.getData("token");
    try {
      final response = await dio.post(
        path!,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> putWithToken({
    String? path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = box.getData("token");
    try {
      final response = await dio.put(
        path!,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> getWithToken({
    String? path,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = box.getData("token");
    try {
      final response = await dio.get(
        path!,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> deleteWithToken({
    String? path,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    var token = box.getData("token");
    try {
      final response = await dio.delete(
        path!,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }
}
