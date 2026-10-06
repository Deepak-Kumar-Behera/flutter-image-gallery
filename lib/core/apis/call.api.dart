import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../consts/const.dart';
import '../enums/enum.dart';
import '../helpers/helper.dart';

final dio = Dio();

class ApiException implements Exception {
  final EApiError type;
  final String message;
  final int? statusCode;

  ApiException(this.type, this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ApiCall {
  ApiCall._privateConstructor();
  static final ApiCall instance = ApiCall._privateConstructor();

  Future<void> configureDio() async {
    dio.options
      ..baseUrl = CApp.baseUrl
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 20)
      ..headers = {'accept': 'application/json'};

    dio.interceptors
      ..clear()
      ..add(InterceptorsWrapper(onRequest: (options, handler) {
        options.queryParameters['key'] = CApp.apiKey;
        handler.next(options);
      }));

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: false, logPrint: (o) => HLogger.instance.logDebug(o)));
    }
  }

  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(path, queryParameters: queryParameters, cancelToken: cancelToken);
      return response.data ?? <String, dynamic>{};
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  Future<Uint8List> getBytes(String url, {CancelToken? cancelToken}) async {
    try {
      final response = await dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
        cancelToken: cancelToken,
      );
      return Uint8List.fromList(response.data ?? []);
    } on DioException catch (e) {
      throw _toApiException(e);
    }
  }

  ApiException _toApiException(DioException e) {
    final code = e.response?.statusCode;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(EApiError.timeout, 'Request timed out. Please try again.');
      case DioExceptionType.connectionError:
        return ApiException(EApiError.noInternet, 'No internet connection.');
      default:
        break;
    }
    if (code == 429) {
      return ApiException(EApiError.rateLimited, 'Rate limit reached. Please wait a moment.', statusCode: code);
    }
    if (code == 400 || code == 401 || code == 403) {
      return ApiException(EApiError.invalidApiKey, 'Invalid or missing API key.', statusCode: code);
    }
    if (code != null && code >= 500) {
      return ApiException(EApiError.server, 'Server error. Please try again later.', statusCode: code);
    }
    return ApiException(EApiError.unknown, 'Something went wrong.', statusCode: code);
  }
}
