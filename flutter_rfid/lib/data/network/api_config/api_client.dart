
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/data/models/entities/user_entity.dart';
import 'package:flutter_rfid/data/models/entities/user_log_entity.dart';
import 'package:flutter_rfid/data/models/request/create_device_request.dart';
import 'package:flutter_rfid/data/models/request/login_request.dart';
import 'package:flutter_rfid/data/models/request/update_device_request.dart';
import 'package:flutter_rfid/data/models/request/user_update_request.dart';
import 'package:flutter_rfid/data/models/response/base_response.dart';
import 'package:flutter_rfid/data/models/response/login_response.dart';
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
  Future<BaseResponse<List<ManageUserEntity>>> getUsers();

  @PUT("/users/{id}")
  Future<BaseResponse> updateUser(@Path("id") int id, @Body() UserUpdateRequest userUpdateRequest);

  @DELETE("/users/{id}")
  Future<BaseResponse> deleteUser(@Path("id") int id);

  @GET("/users-log")
  Future<BaseResponse<List<UserLogEntity>>> getUserLogs();

  @GET("/devices")
  Future<BaseResponse<List<DeviceEntity>>> getDevices();


  @POST("/devices")
  Future<BaseResponse> addDevice(@Body() CreateDeviceRequest request);

  @PUT("/devices/{id}")
  Future<BaseResponse> updateDevice(@Path("id") int id, @Body() UpdateDeviceRequest request);

  @DELETE("/devices/{id}")
  Future<BaseResponse> deleteDevice(@Path("id") int id);
}
