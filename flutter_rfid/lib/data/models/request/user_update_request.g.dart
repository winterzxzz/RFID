// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateRequest _$UserUpdateRequestFromJson(Map<String, dynamic> json) =>
    UserUpdateRequest(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      serialnumber: json['serialnumber'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      deviceUid: json['device_uid'] as String?,
    );

Map<String, dynamic> _$UserUpdateRequestToJson(UserUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'serialnumber': instance.serialnumber,
      'gender': instance.gender,
      'email': instance.email,
      'device_uid': instance.deviceUid,
    };
