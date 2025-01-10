// To parse this JSON data, do
//
//     final updateDeviceRequest = updateDeviceRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'update_device_request.g.dart';

UpdateDeviceRequest updateDeviceRequestFromJson(String str) => UpdateDeviceRequest.fromJson(json.decode(str));

String updateDeviceRequestToJson(UpdateDeviceRequest data) => json.encode(data.toJson());

@JsonSerializable()
class UpdateDeviceRequest {
    @JsonKey(name: "device_name")
    String? deviceName;
    @JsonKey(name: "device_dep")
    String? deviceDep;
    @JsonKey(name: "device_mode")
    int? deviceMode;

    UpdateDeviceRequest({
        this.deviceName,
        this.deviceDep,
        this.deviceMode,
    });

    UpdateDeviceRequest copyWith({
        String? deviceName,
        String? deviceDep,
        int? deviceMode,
    }) => 
        UpdateDeviceRequest(
            deviceName: deviceName ?? this.deviceName,
            deviceDep: deviceDep ?? this.deviceDep,
            deviceMode: deviceMode ?? this.deviceMode,
        );

    factory UpdateDeviceRequest.fromJson(Map<String, dynamic> json) => _$UpdateDeviceRequestFromJson(json);

    Map<String, dynamic> toJson() => _$UpdateDeviceRequestToJson(this);
}
