// To parse this JSON data, do
//
//     final manageUserEntity = manageUserEntityFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'manage_user_entity.g.dart';

List<ManageUserEntity> manageUserEntityFromJson(String str) => List<ManageUserEntity>.from(json.decode(str).map((x) => ManageUserEntity.fromJson(x)));

String manageUserEntityToJson(List<ManageUserEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ManageUserEntity {
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
    @JsonKey(name: "card_uid")
    String? cardUid;
    @JsonKey(name: "card_select")
    int? cardSelect;
    @JsonKey(name: "user_date")
    DateTime? userDate;
    @JsonKey(name: "device_uid")
    String? deviceUid;
    @JsonKey(name: "device_dep")
    String? deviceDep;
    @JsonKey(name: "add_card")
    int? addCard;

    ManageUserEntity({
        this.id,
        this.username,
        this.serialnumber,
        this.gender,
        this.email,
        this.cardUid,
        this.cardSelect,
        this.userDate,
        this.deviceUid,
        this.deviceDep,
        this.addCard,
    });

    ManageUserEntity copyWith({
        int? id,
        String? username,
        String? serialnumber,
        String? gender,
        String? email,
        String? cardUid,
        int? cardSelect,
        DateTime? userDate,
        String? deviceUid,
        String? deviceDep,
        int? addCard,
    }) => 
        ManageUserEntity(
            id: id ?? this.id,
            username: username ?? this.username,
            serialnumber: serialnumber ?? this.serialnumber,
            gender: gender ?? this.gender,
            email: email ?? this.email,
            cardUid: cardUid ?? this.cardUid,
            cardSelect: cardSelect ?? this.cardSelect,
            userDate: userDate ?? this.userDate,
            deviceUid: deviceUid ?? this.deviceUid,
            deviceDep: deviceDep ?? this.deviceDep,
            addCard: addCard ?? this.addCard,
        );

    factory ManageUserEntity.fromJson(Map<String, dynamic> json) => _$ManageUserEntityFromJson(json);

    Map<String, dynamic> toJson() => _$ManageUserEntityToJson(this);
}
