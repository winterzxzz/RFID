

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_rfid/data/models/entities/user_log_entity.dart';
import 'package:flutter_rfid/data/network/api_config/api_client.dart';
import 'package:flutter_rfid/data/network/error/api_error.dart';

abstract class UserLogsRepository {
  Future<Either<ApiError, List<UserLogEntity>>> getUsers();
}

class UserLogsRepositoryImpl extends UserLogsRepository {
  ApiClient apiClient;
  
  UserLogsRepositoryImpl(this.apiClient);
  
  @override
  Future<Either<ApiError, List<UserLogEntity>>> getUsers() async {
    try {
      final response = await apiClient.getUserLogs();
      if(response.statusCode == 200) {
        return Right(response.data ?? []);
      } else {
        return Left(ApiError(statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    } 
  }

} 