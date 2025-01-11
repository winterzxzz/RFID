// To parse this JSON data, do
//
//     final userUpdateRequest = userUpdateRequestFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_update_request.g.dart';

UserUpdateRequest userUpdateRequestFromJson(String str) => UserUpdateRequest.fromJson(json.decode(str));

String userUpdateRequestToJson(UserUpdateRequest data) => json.encode(data.toJson());

@JsonSerializable()
class UserUpdateRequest {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "serialnumber")
  String? serialnumber;
  @JsonKey(name: "gender")
  String? gender;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "device_uid")
    String? deviceUid;

  UserUpdateRequest({
    this.id,
    this.username,
    this.serialnumber,
    this.gender,
    this.email,
    this.deviceUid,
  });

  UserUpdateRequest copyWith({
    int? id,
    String? username,
    String? serialnumber,
    String? gender,
    String? email,
    String? deviceUid,
  }) =>
        UserUpdateRequest(
            id: id ?? this.id,
            username: username ?? this.username,
            serialnumber: serialnumber ?? this.serialnumber,
            gender: gender ?? this.gender,
            email: email ?? this.email,
            deviceUid: deviceUid ?? this.deviceUid,
        );

    factory UserUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserUpdateRequestFromJson(json);

    Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}
