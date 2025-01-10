// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageUserEntity _$ManageUserEntityFromJson(Map<String, dynamic> json) =>
    ManageUserEntity(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      serialnumber: json['serialnumber'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      cardUid: json['card_uid'] as String?,
      cardSelect: (json['card_select'] as num?)?.toInt(),
      userDate: json['user_date'] == null
          ? null
          : DateTime.parse(json['user_date'] as String),
      deviceUid: json['device_uid'] as String?,
      deviceDep: json['device_dep'] as String?,
      addCard: (json['add_card'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ManageUserEntityToJson(ManageUserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'serialnumber': instance.serialnumber,
      'gender': instance.gender,
      'email': instance.email,
      'card_uid': instance.cardUid,
      'card_select': instance.cardSelect,
      'user_date': instance.userDate?.toIso8601String(),
      'device_uid': instance.deviceUid,
      'device_dep': instance.deviceDep,
      'add_card': instance.addCard,
    };
