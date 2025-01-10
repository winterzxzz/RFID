// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceEntity _$DeviceEntityFromJson(Map<String, dynamic> json) => DeviceEntity(
      id: (json['id'] as num?)?.toInt(),
      deviceName: json['device_name'] as String?,
      deviceDep: json['device_dep'] as String?,
      deviceUid: json['device_uid'] as String?,
      deviceDate: json['device_date'] == null
          ? null
          : DateTime.parse(json['device_date'] as String),
      deviceMode: (json['device_mode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeviceEntityToJson(DeviceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_name': instance.deviceName,
      'device_dep': instance.deviceDep,
      'device_uid': instance.deviceUid,
      'device_date': instance.deviceDate?.toIso8601String(),
      'device_mode': instance.deviceMode,
    };
