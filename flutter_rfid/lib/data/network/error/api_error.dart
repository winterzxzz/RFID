// To parse this JSON data, do
//
//     final apirError = apirErrorFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'api_error.g.dart';

ApiError apiErrorFromJson(String str) => ApiError.fromJson(json.decode(str));

String apiErrorToJson(ApiError data) => json.encode(data.toJson());

@JsonSerializable()
class ApiError {
    @JsonKey(name: "status_code")
    int? statusCode;
    @JsonKey(name: "message")
    String? message;

    ApiError({
        this.statusCode,
        this.message,
    });

    ApiError copyWith({
        int? statusCode,
        String? message,
    }) => 
        ApiError(
            statusCode: statusCode ?? this.statusCode,
            message: message ?? this.message,
        );

    factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

    Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}
