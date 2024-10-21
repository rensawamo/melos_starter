import 'dart:io';

import 'package:dio/dio.dart';

final testDioNetworkException = DioException(
  requestOptions: RequestOptions(
    path: 'https://api.openweathermap.org',
  ),
  type: DioExceptionType.connectionError,
  error: const SocketException(
    'Failed host lookup: api.openweathermap.org '
    '(OS Error: No address associated with hostname, errno = 7)',
  ),
  response: Response(
    requestOptions: RequestOptions(
      path: 'https://api.openweathermap.org',
    ),
    statusCode: 404,
    statusMessage: 'Not Found',
  ),
);
