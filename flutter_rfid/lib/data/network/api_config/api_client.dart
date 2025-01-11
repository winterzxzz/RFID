import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/entities/user_entity.dart';
import 'package:flutter_rfid/data/models/request/create_device_request.dart';
import 'package:flutter_rfid/data/models/request/login_request.dart';
import 'package:flutter_rfid/data/models/request/update_device_request.dart';
import 'package:flutter_rfid/data/models/request/user_update_request.dart';
import 'package:flutter_rfid/data/models/response/base_response.dart';
import 'package:flutter_rfid/data/models/response/device_response.dart';
import 'package:flutter_rfid/data/models/response/login_response.dart';
import 'package:flutter_rfid/data/models/response/manage_user_response.dart';
import 'package:flutter_rfid/data/models/response/user_log_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/login")
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET("/user-info")
  Future<BaseResponse<UserEntity>> getUserInfo();

  @GET("/users")
  Future<BaseResponse<ManageUserResponse>> getUsers({
      @Query("page") int? page,
      @Query("limit") int? limit,
      }  );

  @PUT("/users/{id}")
  Future<BaseResponse> updateUser(
      @Path("id") int id, @Body() UserUpdateRequest userUpdateRequest);

  @DELETE("/users/{id}")
  Future<BaseResponse> deleteUser(@Path("id") int id);

  // ?page=1&limit=20&date_start=2025-01-01&date_end=2025-01-10&device_dep=DTVT
  @GET("/users-log")
  Future<BaseResponse<UserLogResponse>> getUserLogs({
      @Query("page") int? page,
      @Query("limit") int? limit,
      @Query("date_start") String? dateStart,
      @Query("date_end") String? dateEnd,
      @Query("device_dep") String? deviceDep,
    }  );

  @GET("/devices")
  Future<BaseResponse<DeviceResponse>> getDevices({
      @Query("page") int? page,
      @Query("limit") int? limit,
    }  );

  @POST("/devices")
  Future<BaseResponse<DeviceEntity>> addDevice(@Body() CreateDeviceRequest request);

  @PUT("/devices/{id}")
  Future<BaseResponse> updateDevice(
      @Path("id") int id, @Body() UpdateDeviceRequest request);

  @DELETE("/devices/{id}")
  Future<BaseResponse> deleteDevice(@Path("id") int id);
}
