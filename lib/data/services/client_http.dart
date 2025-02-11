import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class ClientHttp {
  final Dio _dio;

  ClientHttp(this._dio);

  AsyncResult<Response> get(String url) async {
    try {
      final response = await _dio.get(url);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Response> post(String url, dynamic data) async {
    try {
      final response = await _dio.post(url, data: data);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Response> put(String url, dynamic data) async {
    try {
      final response = await _dio.put(url, data: data);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }

  AsyncResult<Response> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      return Success(response);
    } on DioException catch (e) {
      return Failure(e);
    }
  }
}
