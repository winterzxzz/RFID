// To parse this JSON data, do
//
//     final deviceDetail = deviceDetailFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'device_detail.g.dart';

List<DeviceDetail> deviceDetailFromJson(String str) => List<DeviceDetail>.from(json.decode(str).map((x) => DeviceDetail.fromJson(x)));

String deviceDetailToJson(List<DeviceDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class DeviceDetail {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "user_id")
    final int? userId;
    @JsonKey(name: "device_id")
    final int? deviceId;
    @JsonKey(name: "add_card")
    final int? addCard;
    @JsonKey(name: "card_select")
    final int? cardSelect;
    @JsonKey(name: "card_uid")
    final String? cardUid;
    @JsonKey(name: "add_date")
    final DateTime? addDate;
    @JsonKey(name: "username")
    final String? username;
    @JsonKey(name: "serialnumber")
    final String? serialnumber;
    @JsonKey(name: "gender")
    final String? gender;
    @JsonKey(name: "email")
    final String? email;
    @JsonKey(name: "user_date")
    final DateTime? userDate;

    DeviceDetail({
        this.id,
        this.userId,
        this.deviceId,
        this.addCard,
        this.cardSelect,
        this.cardUid,
        this.addDate,
        this.username,
        this.serialnumber,
        this.gender,
        this.email,
        this.userDate,
    });

    DeviceDetail copyWith({
        int? id,
        int? userId,
        int? deviceId,
        int? addCard,
        int? cardSelect,
        String? cardUid,
        DateTime? addDate,
        String? username,
        String? serialnumber,
        String? gender,
        String? email,
        DateTime? userDate,
    }) => 
        DeviceDetail(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            deviceId: deviceId ?? this.deviceId,
            addCard: addCard ?? this.addCard,
            cardSelect: cardSelect ?? this.cardSelect,
            cardUid: cardUid ?? this.cardUid,
            addDate: addDate ?? this.addDate,
            username: username ?? this.username,
            serialnumber: serialnumber ?? this.serialnumber,
            gender: gender ?? this.gender,
            email: email ?? this.email,
            userDate: userDate ?? this.userDate,
        );

    factory DeviceDetail.fromJson(Map<String, dynamic> json) => _$DeviceDetailFromJson(json);

    Map<String, dynamic> toJson() => _$DeviceDetailToJson(this);
}
