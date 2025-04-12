// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetail _$DeviceDetailFromJson(Map<String, dynamic> json) => DeviceDetail(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      deviceId: (json['device_id'] as num?)?.toInt(),
      addCard: (json['add_card'] as num?)?.toInt(),
      cardSelect: (json['card_select'] as num?)?.toInt(),
      cardUid: json['card_uid'] as String?,
      addDate: json['add_date'] == null
          ? null
          : DateTime.parse(json['add_date'] as String),
      username: json['username'] as String?,
      serialnumber: json['serialnumber'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      userDate: json['user_date'] == null
          ? null
          : DateTime.parse(json['user_date'] as String),
    );

Map<String, dynamic> _$DeviceDetailToJson(DeviceDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'device_id': instance.deviceId,
      'add_card': instance.addCard,
      'card_select': instance.cardSelect,
      'card_uid': instance.cardUid,
      'add_date': instance.addDate?.toIso8601String(),
      'username': instance.username,
      'serialnumber': instance.serialnumber,
      'gender': instance.gender,
      'email': instance.email,
      'user_date': instance.userDate?.toIso8601String(),
    };
