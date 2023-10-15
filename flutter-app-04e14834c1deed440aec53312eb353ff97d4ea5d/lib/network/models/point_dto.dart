// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_dto.freezed.dart';
part 'point_dto.g.dart';

@freezed
class PointDTO with _$PointDTO {
  const factory PointDTO({
    required int id,
    String? name,
    String? address,
    @JsonKey(name: 'crossdocking_id') String? crossdockingId,
    @JsonKey(name: 'crossdocking_name') String? crossdockName,
    @JsonKey(name: 'crossdocking_lat') String? crossdockLat,
    @JsonKey(name: 'crossdocking_long') String? crossdockLong,

    String? status,
    DateTime? date,
    String? from,
    String? to,
    String? lat,
    String? long,
    dynamic type,
    dynamic avatar,
    @JsonKey(name: 'count_products') int? countProducts,
    @JsonKey(name: 'point_type') int? pointType,
    @JsonKey(name: 'created_at') String? createdAt,
    List<ProductDTO>? products,
    List<ContainerDTO>? containers,
  }) = _PointDTO;

  factory PointDTO.fromJson(Map<String, dynamic> json) =>
      _$PointDTOFromJson(json);
}

@freezed
class ProductDTO with _$ProductDTO {
  const factory ProductDTO({
    required int id,
    int? point,
    String? name,
    String? code,
    String? status,

    // @JsonKey(name: 'created_at') String? createdAt,
  }) = _ProductDTO;

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);
}


@unfreezed
class ContainerDTO with _$ContainerDTO {
 factory ContainerDTO({
    @JsonKey(name: "id") int? containerId,
    @JsonKey(name: "point_id") int? pointId,
    String? code,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
    @Default(false) bool isScanned,
    int? status,
    @Default(false) bool isSentAndStored,

    // @JsonKey(name: 'created_at') String? createdAt,
  }) = _ContainerDTO;

  factory ContainerDTO.fromJson(Map<String, dynamic> json) =>
      _$ContainerDTOFromJson(json);
}
