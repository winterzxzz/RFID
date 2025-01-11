// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageUserResponse _$ManageUserResponseFromJson(Map<String, dynamic> json) =>
    ManageUserResponse(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ManageUserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      departments: (json['departments'] as List<dynamic>?)
          ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManageUserResponseToJson(ManageUserResponse instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'items': instance.items,
      'departments': instance.departments,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      id: (json['id'] as num?)?.toInt(),
      deviceUid: json['device_uid'] as String?,
      deviceDep: json['device_dep'] as String?,
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_uid': instance.deviceUid,
      'device_dep': instance.deviceDep,
    };
