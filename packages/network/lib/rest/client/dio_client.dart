import 'dart:io';

import 'package:core_network/rest/dio/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
DioClient dioClient(DioClientRef ref) {
  final dio = ref.watch(dioProvider);
  return DioClientImpl(dio);
}

class DioClientImpl implements DioClient {
  DioClientImpl(
    this.dio,
  );
  Dio dio;

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
    } on SocketException catch (error) {
      throw SocketException(error.message);
    } on FormatException catch (error) {
      throw FormatException(error.message);
    } catch (error) {
      rethrow;
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
