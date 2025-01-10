

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/data/models/request/user_update_request.dart';
import 'package:flutter_rfid/data/network/api_config/api_client.dart';
import 'package:flutter_rfid/data/network/error/api_error.dart';

abstract class ManageUserRepository {
  Future<Either<ApiError, List<ManageUserEntity>>> getUsers();
  Future<Either<ApiError, String>> updateUser(UserUpdateRequest userUpdateRequest);
  Future<Either<ApiError, String>> deleteUser(int id);
}

class ManageUserRepositoryImpl extends ManageUserRepository {
  ApiClient apiClient;
  
  ManageUserRepositoryImpl(this.apiClient);
  
  @override
  Future<Either<ApiError, String>> deleteUser(int id) async {
    try {
      final response = await apiClient.deleteUser(id);
      if(response.statusCode == 200) {
        return Right(response.message ?? 'Unknown error');
      } else {
        return Left(ApiError(statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    } 
  }
  
  @override
  Future<Either<ApiError, List<ManageUserEntity>>> getUsers() async {
    try {
      final response = await apiClient.getUsers();
      if(response.statusCode == 200) {
        return Right(response.data ?? []);
      } else {
        return Left(ApiError(statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    } 
  }
  
  @override
  Future<Either<ApiError, String>> updateUser(UserUpdateRequest userUpdateRequest) async {
    try {
      final response = await apiClient.updateUser(userUpdateRequest.id!, userUpdateRequest);
      if(response.statusCode == 200) {
        return Right(response.message ?? 'Unknown error');
      } else {
        return Left(ApiError(statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    } 
  }
} 