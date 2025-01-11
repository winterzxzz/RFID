
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/request/create_device_request.dart';
import 'package:flutter_rfid/data/models/request/update_device_request.dart';
import 'package:flutter_rfid/data/models/response/base_response.dart';
import 'package:flutter_rfid/data/network/api_config/api_client.dart';
import 'package:flutter_rfid/data/network/error/api_error.dart';


abstract class DeviceRepository {
  Future<Either<ApiError, List<DeviceEntity>>> getDevices();
  Future<Either<ApiError, BaseResponse<DeviceEntity>>> addDevice(CreateDeviceRequest request);
  Future<Either<ApiError, BaseResponse>> updateDevice(int id, UpdateDeviceRequest request);
  Future<Either<ApiError, BaseResponse>> deleteDevice(int id);
}

class DeviceRepositoryImpl extends DeviceRepository {
  ApiClient apiClient;

  DeviceRepositoryImpl(this.apiClient);
  
  @override
  Future<Either<ApiError, BaseResponse<DeviceEntity>>> addDevice(CreateDeviceRequest request) async {
    try {
      final response = await apiClient.addDevice(request);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }
  
  @override
  Future<Either<ApiError, BaseResponse>> deleteDevice(int id) async {
    try {
      final response = await apiClient.deleteDevice(id);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }
  
  @override
  Future<Either<ApiError, List<DeviceEntity>>> getDevices() async {
    try {
      final response = await apiClient.getDevices();
      return Right(response.data ?? []);
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }
  
  @override
  Future<Either<ApiError, BaseResponse>> updateDevice(int id, UpdateDeviceRequest request) async {
    try {
      final response = await apiClient.updateDevice(id, request);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }


  
}

