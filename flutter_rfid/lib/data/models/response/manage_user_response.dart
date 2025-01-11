// To parse this JSON data, do
//
//     final manageUserResponse = manageUserResponseFromJson(jsonString);

import 'package:flutter_rfid/data/models/entities/manage_user_entity.dart';
import 'package:flutter_rfid/data/models/response/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'manage_user_response.g.dart';

ManageUserResponse manageUserResponseFromJson(String str) => ManageUserResponse.fromJson(json.decode(str));

String manageUserResponseToJson(ManageUserResponse data) => json.encode(data.toJson());

@JsonSerializable()
class ManageUserResponse {
    @JsonKey(name: "pagination")
    Pagination? pagination;
    @JsonKey(name: "items")
    List<ManageUserEntity>? items;
    @JsonKey(name: "departments")
    List<Department>? departments;

    ManageUserResponse({
        this.pagination,
        this.items,
        this.departments,
    });

    ManageUserResponse copyWith({
        Pagination? pagination,
        List<ManageUserEntity>? items,
        List<Department>? departments,
    }) => 
        ManageUserResponse(
            pagination: pagination ?? this.pagination,
            items: items ?? this.items,
            departments: departments ?? this.departments,
        );

    factory ManageUserResponse.fromJson(Map<String, dynamic> json) => _$ManageUserResponseFromJson(json);

    Map<String, dynamic> toJson() => _$ManageUserResponseToJson(this);
}

@JsonSerializable()
class Department {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "device_uid")
    String? deviceUid;
    @JsonKey(name: "device_dep")
    String? deviceDep;

    Department({
        this.id,
        this.deviceUid,
        this.deviceDep,
    });

    Department copyWith({
        int? id,
        String? deviceUid,
        String? deviceDep,
    }) => 
        Department(
            id: id ?? this.id,
            deviceUid: deviceUid ?? this.deviceUid,
            deviceDep: deviceDep ?? this.deviceDep,
        );

    factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

    Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}

