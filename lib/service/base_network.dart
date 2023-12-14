import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:paxa_health/utils/app_logger.dart';

class BaseNetworkService {
  static const String baseUrl = 'http://3.108.68.144:5000';

  final String? subPath;
  BaseNetworkService({this.subPath}) {
    init();
  }
  static String? token;
  Dio _dio = Dio();
  Dio get dio => _dio;

  set dio(Dio value) => _dio = value;
  init() {
    var options = BaseOptions(
        connectTimeout: const Duration(seconds: 15), // 60 seconds
        receiveTimeout: const Duration(seconds: 30),
        // baseUrl: kReleaseMode ? baseUrl : devBaseUrl,
        baseUrl: baseUrl);
    dio = Dio(options)
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options, handle) =>
              requestInterceptor(options, handle),
          onResponse: (Response response, handle) =>
              responseInterceptor(response, handle),
          onError: (DioException dioError, handle) =>
              errorInterceptor(dioError, handle)));
  }

  void requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handle) async {
    AppLogger.print('headers : ${options.headers}');
    AppLogger.print(options.baseUrl + options.path);
    AppLogger.print(options.data);
    if (options.data is FormData) {
      AppLogger.print((options.data as FormData).files);
      AppLogger.print((options.data as FormData).fields);
    }
    AppLogger.print(options.headers);
    handle.next(options);
  }

  void responseInterceptor(
      Response res, ResponseInterceptorHandler handle) async {
    AppLogger.print(res.realUri.origin + res.realUri.path);
    AppLogger.print(res.data);
    handle.next(res);
  }

  void errorInterceptor(DioError dioError, ErrorInterceptorHandler handle) {
    AppLogger.print(dioError);
    handle.next(dioError);
  }

  changeContentType(String contentType) {
    dio.options.contentType = contentType;
  }

  removeToken() {
    token = null;
  }

  Future<NetworkResponse?> get(String path,
      {bool showMessage = true, Map<String, dynamic>? data}) async {
    try {
      String url;
      if (subPath == null) {
        url = path;
      } else {
        url = subPath! + path;
      }
      final res = await dio.get(url, queryParameters: data);
      if (res.data is String) {
        throw DioException(
            requestOptions: res.requestOptions,
            type: DioExceptionType.unknown,
            response: res);
      }
      return NetworkResponse.ok(res.data);
    } on DioException catch (error, s) {
      AppLogger.error(error.toString(), s);
      AppLogger.error(error.response.toString(), s);
      if (error.type == DioExceptionType.unknown) {
        // showToast('Check your internet connectivity');
        // TODO :
        rethrow;
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        // showToast('Check your internet connectivity');
        // TODO :
        rethrow;
      }
      final errorText = error.toString();

      // showToast(error.response?.data['message'] ??
      //     error.response?.statusCode.toString() ??
      //     'Unable to process request');

      if (error.response?.statusCode != null &&
          error.response!.statusCode! >= 500) {
        // TODO :
        rethrow;
      }
      switch (error.response?.statusCode) {
        case 400:
          return NetworkResponse.badRequest(errorText);
        case 401:
          return NetworkResponse.noAuth(errorText);
        case 403:
          return NetworkResponse.noAccess(errorText);
        case 404:
          return NetworkResponse.notFound(errorText);
        case 409:
          return NetworkResponse.conflict(errorText);
        default:
          return NetworkResponse.noData(errorText);
      }
    } on SocketException {
      // showToast('No Internet Connection');
    } catch (error, s) {
      return NetworkResponse.noData(error.toString());
    }
  }

  Future<NetworkResponse?> post(String path,
      {bool showMessage = true, required dynamic data}) async {
    try {
      String url;
      if (subPath == null) {
        url = path;
      } else {
        url = subPath! + path;
      }
      final res = await dio.post(url, data: data);
      return NetworkResponse.ok(res.data);
    } on DioException catch (error, s) {
      AppLogger.error(error.toString(), s);
      AppLogger.error(error.response.toString(), s);
      if (error.type == DioExceptionType.unknown) {
        // showToast('Check your internet connectivity');
        // TODO :
        rethrow;
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        // showToast('Check your internet connectivity');

        rethrow;
      }
      final errorText = error.toString();
      // showToast(error.response?.data['message'] ??
      //     error.response?.statusCode.toString() ??
      //     'Unable to process request');
      if (error.response?.statusCode != null &&
          error.response!.statusCode! >= 500) {
        // TODO :
        rethrow;
      }
      switch (error.response?.statusCode) {
        case 400:
          return NetworkResponse.badRequest(errorText);
        case 401:
          return NetworkResponse.noAuth(errorText);
        case 403:
          return NetworkResponse.noAccess(errorText);
        case 404:
          return NetworkResponse.notFound(errorText);
        case 409:
          return NetworkResponse.conflict(errorText);
        default:
          return NetworkResponse.noData(errorText);
      }
    } on SocketException {
      // showToast('No Internet Connection');
    } catch (error, s) {
      return NetworkResponse.noData(error.toString());
    }
  }

  Future<NetworkResponse?> patch(String path, {dynamic data}) async {
    try {
      String url;
      if (subPath == null) {
        url = path;
      } else {
        url = subPath! + path;
      }
      final res = await dio.patch(path, data: data);
      return NetworkResponse.ok(res.data);
    } on DioException catch (error, s) {
      AppLogger.error(error.toString(), s);
      AppLogger.error(error.response.toString(), s);
      if (error.type == DioExceptionType.unknown) {
        // showToast('Check your internet connectivity');
        // TODO :
        rethrow;
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        // showToast('Check your internet connectivity');
        // TODO :
        rethrow;
      }
      final errorText = error.toString();
      // showToast(error.response?.data['message'] ??
      //     error.response?.statusCode.toString() ??
      //     'Unable to process request');
      if (error.response?.statusCode != null &&
          error.response!.statusCode! >= 500) {
        // TODO :
        rethrow;
      }
      switch (error.response?.statusCode) {
        case 400:
          return NetworkResponse.badRequest(errorText);
        case 401:
          return NetworkResponse.noAuth(errorText);
        case 403:
          return NetworkResponse.noAccess(errorText);
        case 404:
          return NetworkResponse.notFound(errorText);
        case 409:
          return NetworkResponse.conflict(errorText);
        default:
          return NetworkResponse.noData(errorText);
      }
    } on SocketException {
      // showToast('Check your internet connectivity');
    } catch (error, s) {
      return NetworkResponse.noData(error.toString());
    }
  }

  Future<NetworkResponse?> del(String path, {dynamic data}) async {
    try {
      String url;
      if (subPath == null) {
        url = path;
      } else {
        url = subPath! + path;
      }
      final res = await dio.delete(url, data: data);
      return NetworkResponse.ok(res.data);
    } on DioException catch (error, s) {
      if (error.type == DioExceptionType.unknown) {
        // showToast('Check your internet connectivity');
        // TODO :
        rethrow;
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        // showToast('Check your internet connectivity');
        // TODO :
        rethrow;
      }
      final errorText = error.toString();
      // showToast(error.response?.data['message'] ??
      //     error.response?.statusCode.toString() ??
      //     'Unable to process request');

      if (error.response?.statusCode != null &&
          error.response!.statusCode! >= 500) {
        // TODO :

        rethrow;
      }
      switch (error.response?.statusCode) {
        case 400:
          return NetworkResponse.badRequest(errorText);
        case 401:
          return NetworkResponse.noAuth(errorText);
        case 403:
          return NetworkResponse.noAccess(errorText);
        case 404:
          return NetworkResponse.notFound(errorText);
        case 409:
          return NetworkResponse.conflict(errorText);
        default:
          return NetworkResponse.noData(errorText);
      }
    } on SocketException {
      // showToast('Check your internet connectivity');
    } catch (error, s) {
      return NetworkResponse.noData(error.toString());
    }
  }

  Future<NetworkResponse?> put(String path,
      {bool showMessage = true, required dynamic data}) async {
    try {
      String url;
      if (subPath == null) {
        url = path;
      } else {
        url = subPath! + path;
      }
      final res = await dio.put(url, data: data);
      return NetworkResponse.ok(res.data);
    } on DioException catch (error, s) {
      if (error.type == DioExceptionType.unknown) {
        // showToast('Check your internet connectivity');
        // TODO :
        rethrow;
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        // showToast('Check your internet connectivity');

        rethrow;
      }
      final errorText = error.toString();
      // showToast(error.response?.data['message'] ??
      //     error.response?.statusCode.toString() ??
      //     'Unable to process request');
      if (error.response?.statusCode != null &&
          error.response!.statusCode! >= 500) {
        // TODO :
        rethrow;
      }
      switch (error.response?.statusCode) {
        case 400:
          return NetworkResponse.badRequest(errorText);
        case 401:
          return NetworkResponse.noAuth(errorText);
        case 403:
          return NetworkResponse.noAccess(errorText);
        case 404:
          return NetworkResponse.notFound(errorText);
        case 409:
          return NetworkResponse.conflict(errorText);
        default:
          return NetworkResponse.noData(errorText);
      }
    } on SocketException {
      // showToast('No Internet Connection');
    } catch (error, s) {
      return NetworkResponse.noData(error.toString());
    }
  }
}

class NetworkResponse<T> {
  final T? data;
  final String? message;
  final int statusCode;

  NetworkResponse.ok(this.data)
      : statusCode = 200,
        message = null;
  NetworkResponse.invalidParameters(this.message)
      : statusCode = 422,
        data = null;
  NetworkResponse.noAuth(this.message)
      : statusCode = 401,
        data = null;
  NetworkResponse.noAccess(this.message)
      : statusCode = 403,
        data = null;
  NetworkResponse.badRequest(this.message)
      : statusCode = 400,
        data = null;
  NetworkResponse.notFound(this.message)
      : statusCode = 404,
        data = null;
  NetworkResponse.conflict(this.message)
      : statusCode = 409,
        data = null;
  NetworkResponse.noData(this.message)
      : statusCode = 500,
        data = null;

  bool get isSuccessful => statusCode == 200 || statusCode == 201;
  bool get isInvalidParameters => statusCode == 422;
  bool get isNoAuth => statusCode == 401;
  bool get isNoAccess => statusCode == 403;
  bool get isBadRequest => statusCode == 400;
  bool get isNotFound => statusCode == 404;
  bool get isConflict => statusCode == 409;
  bool get isNoData => statusCode == 500;
}
