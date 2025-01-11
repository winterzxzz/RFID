// To parse this JSON data, do
//
//     final deviceResponse = deviceResponseFromJson(jsonString);

import 'package:flutter_rfid/data/models/entities/device_entity.dart';
import 'package:flutter_rfid/data/models/response/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'device_response.g.dart';

DeviceResponse deviceResponseFromJson(String str) => DeviceResponse.fromJson(json.decode(str));

String deviceResponseToJson(DeviceResponse data) => json.encode(data.toJson());

@JsonSerializable()
class DeviceResponse {
    @JsonKey(name: "pagination")
    Pagination? pagination;
    @JsonKey(name: "items")
    List<DeviceEntity>? items;

    DeviceResponse({
        this.pagination,
        this.items,
    });

    DeviceResponse copyWith({
        Pagination? pagination,
        List<DeviceEntity>? items,
    }) => 
        DeviceResponse(
            pagination: pagination ?? this.pagination,
            items: items ?? this.items,
        );

    factory DeviceResponse.fromJson(Map<String, dynamic> json) => _$DeviceResponseFromJson(json);

    Map<String, dynamic> toJson() => _$DeviceResponseToJson(this);
}
