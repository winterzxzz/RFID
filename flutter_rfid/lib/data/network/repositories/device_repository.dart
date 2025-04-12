import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_rfid/data/models/entities/device_detail.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/request/create_device_request.dart';
import 'package:flutter_rfid/data/models/request/update_device_request.dart';
import 'package:flutter_rfid/data/models/response/device_response.dart';
import 'package:flutter_rfid/data/network/api_config/api_client.dart';
import 'package:flutter_rfid/data/network/error/api_error.dart';

abstract class DeviceRepository {
  Future<Either<ApiError, DeviceResponse>> getDevices({
    int? page,
    int? limit,
  });
  Future<Either<ApiError, DeviceEntity>> addDevice(CreateDeviceRequest request);
  Future<Either<ApiError, String>> updateDevice(
      int id, UpdateDeviceRequest request);
  Future<Either<ApiError, String>> deleteDevice(int id);

  Future<Either<ApiError, List<DeviceDetail>>> getDeviceDetail(int id);

  Future<Either<ApiError, String>> deleteUserDevice(int userId, int deviceId);
}

class DeviceRepositoryImpl extends DeviceRepository {
  ApiClient apiClient;

  DeviceRepositoryImpl(this.apiClient);

  @override
  Future<Either<ApiError, DeviceEntity>> addDevice(
      CreateDeviceRequest request) async {
    try {
      final response = await apiClient.addDevice(request);
      return Right(response.data!);
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ApiError, String>> deleteDevice(int id) async {
    try {
      final response = await apiClient.deleteDevice(id);
      if (response.statusCode == 200) {
        return Right(response.message ?? 'Unknown error');
      } else {
        return Left(ApiError(
            statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ApiError, DeviceResponse>> getDevices({
    int? page,
    int? limit,
  }) async {
    try {
      final response = await apiClient.getDevices(page: page, limit: limit);
      return Right(response.data!);
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ApiError, String>> updateDevice(
      int id, UpdateDeviceRequest request) async {
    try {
      final response = await apiClient.updateDevice(id, request);
      if (response.statusCode == 200) {
        return Right(response.message ?? 'Unknown error');
      } else {
        return Left(ApiError(
            statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ApiError, List<DeviceDetail>>> getDeviceDetail(int id) async {
    try {
      final response = await apiClient.getDeviceDetail(id);
      if (response.statusCode == 200) {
        return Right(response.data!);
      } else {
        return Left(ApiError(
            statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }

  @override
  Future<Either<ApiError, String>> deleteUserDevice(
      int userId, int deviceId) async {
    try {
      final response = await apiClient.deleteUserDevice(userId, deviceId);
      if (response.statusCode == 200) {
        return Right(response.message ?? 'Unknown error');
      } else {
        return Left(ApiError(
            statusCode: response.statusCode, message: response.message));
      }
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }
}
