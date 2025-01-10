// To parse this JSON data, do
//
//     final createDeviceRequest = createDeviceRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'create_device_request.g.dart';

CreateDeviceRequest createDeviceRequestFromJson(String str) => CreateDeviceRequest.fromJson(json.decode(str));

String createDeviceRequestToJson(CreateDeviceRequest data) => json.encode(data.toJson());

@JsonSerializable()
class CreateDeviceRequest {
    @JsonKey(name: "device_name")
    String? deviceName;
    @JsonKey(name: "device_dep")
    String? deviceDep;

    CreateDeviceRequest({
        this.deviceName,
        this.deviceDep,
    });

    CreateDeviceRequest copyWith({
        String? deviceName,
        String? deviceDep,
    }) => 
        CreateDeviceRequest(
            deviceName: deviceName ?? this.deviceName,
            deviceDep: deviceDep ?? this.deviceDep,
        );

    factory CreateDeviceRequest.fromJson(Map<String, dynamic> json) => _$CreateDeviceRequestFromJson(json);

    Map<String, dynamic> toJson() => _$CreateDeviceRequestToJson(this);
}
