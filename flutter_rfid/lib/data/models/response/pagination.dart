
import 'package:json_annotation/json_annotation.dart';
part 'pagination.g.dart';


@JsonSerializable()
class Pagination {
    @JsonKey(name: "total")
    int? total;
    @JsonKey(name: "totalPages")
    int? totalPages;
    @JsonKey(name: "currentPage")
    int? currentPage;
    @JsonKey(name: "limit")
    int? limit;

    Pagination({
        this.total,
        this.totalPages,
        this.currentPage,
        this.limit,
    });

    Pagination copyWith({
        int? total,
        int? totalPages,
        int? currentPage,
        int? limit,
    }) => 
        Pagination(
            total: total ?? this.total,
            totalPages: totalPages ?? this.totalPages,
            currentPage: currentPage ?? this.currentPage,
            limit: limit ?? this.limit,
        );

    factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

    Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

