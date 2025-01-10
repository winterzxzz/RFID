// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_request.g.dart';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

@JsonSerializable()
class LoginRequest {
    @JsonKey(name: "admin_email")
    String? adminEmail;
    @JsonKey(name: "admin_pwd")
    String? adminPwd;

    LoginRequest({
        this.adminEmail,
        this.adminPwd,
    });

    LoginRequest copyWith({
        String? adminEmail,
        String? adminPwd,
    }) => 
        LoginRequest(
            adminEmail: adminEmail ?? this.adminEmail,
            adminPwd: adminPwd ?? this.adminPwd,
        );

    factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

    Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
