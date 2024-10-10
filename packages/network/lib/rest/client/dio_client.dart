import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_di_provider/connectivity/connectivity_provider.dart';
import 'package:core_foundation/enum/app_dio_exception.dart';
import 'package:core_foundation/foundation.dart';
import 'package:core_network/rest/dio/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
DioClient dioClient(DioClientRef ref) {
  final dio = ref.watch(dioProvider);
  final connectivity = ref.watch(connectivityProvider);

  return DioClientImpl(dio, connectivity);
}

class DioClientImpl implements DioClient {
  DioClientImpl(
    this.dio,
    this._connectivity,
  );
  final Dio dio;
  final Connectivity _connectivity;

  @override
  Future<dynamic> get(
    String uri, {
    dynamic data,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {

    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }

      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.get<dynamic>(
        uri,
        queryParameters: queryParameters,
        options: options,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException {
      throw AppError.socketException();
    } on FormatException {
      throw AppError.formatException();
    } on DioException catch (error) {
      throw AppDioException(
        AppErrorType.dioException,
      ).fromDioException(error);
    } catch (error) {
      throw AppError.unknownError(
        'Failed to fetch data: $error',
      );
    }
  }

  @override
  Future<dynamic> post(
    String uri, {
    List<Interceptor>? interceptors,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw AppError.noInternetConnection();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.post<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String uri, {
    List<Interceptor>? interceptors,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw AppError.noInternetConnection();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.put<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(
    String uri, {
    dynamic data,
    List<Interceptor>? interceptors,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw AppError.noInternetConnection();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.delete<dynamic>(
        uri,
        data: data,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> download(
    String url,
    String savePath, {
    dynamic data,
    List<Interceptor>? interceptors,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (dio.interceptors.isNotEmpty) {
        dio.interceptors.clear();
      }
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        throw AppError.noInternetConnection();
      }
      if (interceptors != null) {
        dio.interceptors.addAll(interceptors);
      }
      final response = await dio.download(
        url,
        savePath,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
    }
  }
}

abstract class DioClient {
  Future<dynamic> get(
    String url, {
    dynamic data,
    List<Interceptor>? interceptors,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback? onReceiveProgress,
  });
  Future<dynamic> download(
    String url,
    String savePath, {
    List<Interceptor>? interceptors,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback? onReceiveProgress,
  });
  Future<dynamic> post(
    String uri, {
    List<Interceptor>? interceptors,
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options? options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });
  Future<dynamic> put(
    String uri, {
    List<Interceptor>? interceptors,
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options? options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  });

  Future<dynamic> delete(
    String uri, {
    dynamic data,
    List<Interceptor>? interceptors,
  });
}
