// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:flutter_rfid/data/models/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_response.g.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

@JsonSerializable()
class LoginResponse {
    @JsonKey(name: "status_code")
    int? statusCode;
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "token")
    String? token;
    @JsonKey(name: "data")
    UserEntity? data;

    LoginResponse({
        this.statusCode,
        this.message,
        this.token,
        this.data,
    });

    LoginResponse copyWith({
        int? statusCode,
        String? message,
        String? token,
        UserEntity? data,
    }) => 
        LoginResponse(
            statusCode: statusCode ?? this.statusCode,
            message: message ?? this.message,
            token: token ?? this.token,
            data: data ?? this.data,
        );

    factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

    Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}