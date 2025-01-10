// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_device_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDeviceRequest _$UpdateDeviceRequestFromJson(Map<String, dynamic> json) =>
    UpdateDeviceRequest(
      deviceName: json['device_name'] as String?,
      deviceDep: json['device_dep'] as String?,
      deviceUid: json['device_uid'] as String?,
      deviceMode: (json['device_mode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateDeviceRequestToJson(
        UpdateDeviceRequest instance) =>
    <String, dynamic>{
      'device_name': instance.deviceName,
      'device_dep': instance.deviceDep,
      'device_uid': instance.deviceUid,
      'device_mode': instance.deviceMode,
    };
