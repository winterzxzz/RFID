
import 'package:dio/dio.dart';
import 'package:flutter_rfid/data/database/share_preferences_helper.dart';

import '../../../common/utils/logger.dart';

class ApiInterceptors extends QueuedInterceptorsWrapper {

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = SharedPreferencesHelper().getApiToken();
    options.headers['Accept'] = 'application/json';
    if (token.isNotEmpty) {
      logger.d('token: $token');
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;
    logger.e(
        "⚠️ ERROR[$statusCode] => PATH: $path \n Response: ${err.response?.data}");
    switch (statusCode) {
      case 401 || 403:
        await SharedPreferencesHelper().removeApiToken();
        handler.next(err);
      default:
        handler.next(err);
    }
  }
}
