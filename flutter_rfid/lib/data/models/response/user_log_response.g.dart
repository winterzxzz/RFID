// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_log_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLogResponse _$UserLogResponseFromJson(Map<String, dynamic> json) =>
    UserLogResponse(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => UserLogEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserLogResponseToJson(UserLogResponse instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'items': instance.items,
    };
