// To parse this JSON data, do
//
//     final deviceEntity = deviceEntityFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'device_entity.g.dart';

List<DeviceEntity> deviceEntityFromJson(String str) => List<DeviceEntity>.from(json.decode(str).map((x) => DeviceEntity.fromJson(x)));

String deviceEntityToJson(List<DeviceEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class DeviceEntity {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "device_name")
    String? deviceName;
    @JsonKey(name: "device_dep")
    String? deviceDep;
    @JsonKey(name: "device_uid")
    String? deviceUid;
    @JsonKey(name: "device_date")
    DateTime? deviceDate;
    @JsonKey(name: "device_mode")
    int? deviceMode;

    DeviceEntity({
        this.id,
        this.deviceName,
        this.deviceDep,
        this.deviceUid,
        this.deviceDate,
        this.deviceMode,
    });

    DeviceEntity copyWith({
        int? id,
        String? deviceName,
        String? deviceDep,
        String? deviceUid,
        DateTime? deviceDate,
        int? deviceMode,
    }) => 
        DeviceEntity(
            id: id ?? this.id,
            deviceName: deviceName ?? this.deviceName,
            deviceDep: deviceDep ?? this.deviceDep,
            deviceUid: deviceUid ?? this.deviceUid,
            deviceDate: deviceDate ?? this.deviceDate,
            deviceMode: deviceMode ?? this.deviceMode,
        );

    factory DeviceEntity.fromJson(Map<String, dynamic> json) => _$DeviceEntityFromJson(json);

    Map<String, dynamic> toJson() => _$DeviceEntityToJson(this);
}
