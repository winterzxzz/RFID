// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_device_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDeviceRequest _$CreateDeviceRequestFromJson(Map<String, dynamic> json) =>
    CreateDeviceRequest(
      deviceName: json['device_name'] as String?,
      deviceDep: json['device_dep'] as String?,
    );

Map<String, dynamic> _$CreateDeviceRequestToJson(
        CreateDeviceRequest instance) =>
    <String, dynamic>{
      'device_name': instance.deviceName,
      'device_dep': instance.deviceDep,
    };
