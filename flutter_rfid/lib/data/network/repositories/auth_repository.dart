
import 'package:dio/dio.dart';
import 'package:flutter_rfid/data/models/entities/user_entity.dart';
import 'package:flutter_rfid/data/models/request/login_request.dart';
import 'package:flutter_rfid/data/models/response/login_response.dart';
import 'package:flutter_rfid/data/network/api_config/api_client.dart';
import 'package:flutter_rfid/data/network/error/api_error.dart';
import 'package:either_dart/either.dart';
abstract class AuthRepository {
  Future<Either<ApiError, LoginResponse>> login(LoginRequest loginRequest);
  Future<Either<ApiError, UserEntity>> getUserInfo();
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;

  AuthRepositoryImpl(this.apiClient);

  @override
  Future<Either<ApiError, LoginResponse>> login(LoginRequest loginRequest) async {
    try { 
      final response = await apiClient.login(loginRequest);
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ApiError, UserEntity>> getUserInfo() async {
    try {
      final response = await apiClient.getUserInfo();
      return Right(response.data!);
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }
}

