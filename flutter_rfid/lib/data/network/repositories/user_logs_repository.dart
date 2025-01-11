

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_rfid/data/models/response/user_log_response.dart';
import 'package:flutter_rfid/data/network/api_config/api_client.dart';
import 'package:flutter_rfid/data/network/error/api_error.dart';

abstract class UserLogsRepository {
  Future<Either<ApiError, UserLogResponse>> getUsers({
    int? page,
    int? limit,
    String? dateStart,
    String? dateEnd,
    String? deviceDep,
  });
}

class UserLogsRepositoryImpl extends UserLogsRepository {
  ApiClient apiClient;
  
  UserLogsRepositoryImpl(this.apiClient);
  
  @override
  Future<Either<ApiError, UserLogResponse>> getUsers({
    int? page,
    int? limit,
    String? dateStart,
    String? dateEnd,
    String? deviceDep,
  }) async {
    try {
      final response = await apiClient.getUserLogs(
        page: page,
        limit: limit,
        dateStart: dateStart,
        dateEnd: dateEnd,
        deviceDep: deviceDep,
      );
      if(response.statusCode == 200) {
        return Right(response.data!);
      } else {
        return Left(ApiError(statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    } 
  }

} 