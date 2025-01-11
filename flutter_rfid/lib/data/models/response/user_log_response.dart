// To parse this JSON data, do
//
//     final userLogResponse = userLogResponseFromJson(jsonString);

import 'package:flutter_rfid/data/models/entities/user_log_entity.dart';
import 'package:flutter_rfid/data/models/response/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_log_response.g.dart';

UserLogResponse userLogResponseFromJson(String str) => UserLogResponse.fromJson(json.decode(str));

String userLogResponseToJson(UserLogResponse data) => json.encode(data.toJson());

@JsonSerializable()
class UserLogResponse {
    @JsonKey(name: "pagination")
    Pagination? pagination;
    @JsonKey(name: "items")
    List<UserLogEntity>? items;

    UserLogResponse({
        this.pagination,
        this.items,
    });

    UserLogResponse copyWith({
        Pagination? pagination,
        List<UserLogEntity>? items,
    }) => 
        UserLogResponse(
            pagination: pagination ?? this.pagination,
            items: items ?? this.items,
        );

    factory UserLogResponse.fromJson(Map<String, dynamic> json) => _$UserLogResponseFromJson(json);

    Map<String, dynamic> toJson() => _$UserLogResponseToJson(this);
}
