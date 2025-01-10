// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_log_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLogEntity _$UserLogEntityFromJson(Map<String, dynamic> json) =>
    UserLogEntity(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      serialnumber: json['serialnumber'] as String?,
      cardUid: json['card_uid'] as String?,
      deviceUid: json['device_uid'] as String?,
      deviceDep: json['device_dep'] as String?,
      checkindate: json['checkindate'] == null
          ? null
          : DateTime.parse(json['checkindate'] as String),
      timein: json['timein'] as String?,
      timeout: json['timeout'] as String?,
      cardOut: (json['card_out'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserLogEntityToJson(UserLogEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'serialnumber': instance.serialnumber,
      'card_uid': instance.cardUid,
      'device_uid': instance.deviceUid,
      'device_dep': instance.deviceDep,
      'checkindate': instance.checkindate?.toIso8601String(),
      'timein': instance.timein,
      'timeout': instance.timeout,
      'card_out': instance.cardOut,
    };
