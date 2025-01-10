// To parse this JSON data, do
//
//     final userEntity = userEntityFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_entity.g.dart';

UserEntity userEntityFromJson(String str) => UserEntity.fromJson(json.decode(str));

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

@JsonSerializable()
class UserEntity {
    @JsonKey(name: "name")
    String? name;
    @JsonKey(name: "email")
    String? email;

    UserEntity({
        this.name,
        this.email,
    });

    UserEntity copyWith({
        String? name,
        String? email,
    }) => 
        UserEntity(
            name: name ?? this.name,
            email: email ?? this.email,
        );

    factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

    Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
