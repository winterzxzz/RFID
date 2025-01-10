// To parse this JSON data, do
//
//     final userLogEntity = userLogEntityFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_log_entity.g.dart';

List<UserLogEntity> userLogEntityFromJson(String str) => List<UserLogEntity>.from(json.decode(str).map((x) => UserLogEntity.fromJson(x)));

String userLogEntityToJson(List<UserLogEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class UserLogEntity {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "username")
    String? username;
    @JsonKey(name: "serialnumber")
    String? serialnumber;
    @JsonKey(name: "card_uid")
    String? cardUid;
    @JsonKey(name: "device_uid")
    String? deviceUid;
    @JsonKey(name: "device_dep")
    String? deviceDep;
    @JsonKey(name: "checkindate")
    DateTime? checkindate;
    @JsonKey(name: "timein")
    String? timein;
    @JsonKey(name: "timeout")
    String? timeout;
    @JsonKey(name: "card_out")
    int? cardOut;

    UserLogEntity({
        this.id,
        this.username,
        this.serialnumber,
        this.cardUid,
        this.deviceUid,
        this.deviceDep,
        this.checkindate,
        this.timein,
        this.timeout,
        this.cardOut,
    });

    UserLogEntity copyWith({
        int? id,
        String? username,
        String? serialnumber,
        String? cardUid,
        String? deviceUid,
        String? deviceDep,
        DateTime? checkindate,
        String? timein,
        String? timeout,
        int? cardOut,
    }) => 
        UserLogEntity(
            id: id ?? this.id,
            username: username ?? this.username,
            serialnumber: serialnumber ?? this.serialnumber,
            cardUid: cardUid ?? this.cardUid,
            deviceUid: deviceUid ?? this.deviceUid,
            deviceDep: deviceDep ?? this.deviceDep,
            checkindate: checkindate ?? this.checkindate,
            timein: timein ?? this.timein,
            timeout: timeout ?? this.timeout,
            cardOut: cardOut ?? this.cardOut,
        );

    factory UserLogEntity.fromJson(Map<String, dynamic> json) => _$UserLogEntityFromJson(json);

    Map<String, dynamic> toJson() => _$UserLogEntityToJson(this);
}
