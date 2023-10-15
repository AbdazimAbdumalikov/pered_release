// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PointDTO _$PointDTOFromJson(Map<String, dynamic> json) {
  return _PointDTO.fromJson(json);
}

/// @nodoc
mixin _$PointDTO {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'crossdocking_id')
  String? get crossdockingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'crossdocking_name')
  String? get crossdockName => throw _privateConstructorUsedError;
  @JsonKey(name: 'crossdocking_lat')
  String? get crossdockLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'crossdocking_long')
  String? get crossdockLong => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get from => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  String? get lat => throw _privateConstructorUsedError;
  String? get long => throw _privateConstructorUsedError;
  dynamic get type => throw _privateConstructorUsedError;
  dynamic get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'count_products')
  int? get countProducts => throw _privateConstructorUsedError;
  @JsonKey(name: 'point_type')
  int? get pointType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  List<ProductDTO>? get products => throw _privateConstructorUsedError;
  List<ContainerDTO>? get containers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointDTOCopyWith<PointDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointDTOCopyWith<$Res> {
  factory $PointDTOCopyWith(PointDTO value, $Res Function(PointDTO) then) =
      _$PointDTOCopyWithImpl<$Res, PointDTO>;
  @useResult
  $Res call(
      {int id,
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
      List<ContainerDTO>? containers});
}

/// @nodoc
class _$PointDTOCopyWithImpl<$Res, $Val extends PointDTO>
    implements $PointDTOCopyWith<$Res> {
  _$PointDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? address = freezed,
    Object? crossdockingId = freezed,
    Object? crossdockName = freezed,
    Object? crossdockLat = freezed,
    Object? crossdockLong = freezed,
    Object? status = freezed,
    Object? date = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? lat = freezed,
    Object? long = freezed,
    Object? type = freezed,
    Object? avatar = freezed,
    Object? countProducts = freezed,
    Object? pointType = freezed,
    Object? createdAt = freezed,
    Object? products = freezed,
    Object? containers = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      crossdockingId: freezed == crossdockingId
          ? _value.crossdockingId
          : crossdockingId // ignore: cast_nullable_to_non_nullable
              as String?,
      crossdockName: freezed == crossdockName
          ? _value.crossdockName
          : crossdockName // ignore: cast_nullable_to_non_nullable
              as String?,
      crossdockLat: freezed == crossdockLat
          ? _value.crossdockLat
          : crossdockLat // ignore: cast_nullable_to_non_nullable
              as String?,
      crossdockLong: freezed == crossdockLong
          ? _value.crossdockLong
          : crossdockLong // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String?,
      long: freezed == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as dynamic,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as dynamic,
      countProducts: freezed == countProducts
          ? _value.countProducts
          : countProducts // ignore: cast_nullable_to_non_nullable
              as int?,
      pointType: freezed == pointType
          ? _value.pointType
          : pointType // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductDTO>?,
      containers: freezed == containers
          ? _value.containers
          : containers // ignore: cast_nullable_to_non_nullable
              as List<ContainerDTO>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PointDTOCopyWith<$Res> implements $PointDTOCopyWith<$Res> {
  factory _$$_PointDTOCopyWith(
          _$_PointDTO value, $Res Function(_$_PointDTO) then) =
      __$$_PointDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
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
      List<ContainerDTO>? containers});
}

/// @nodoc
class __$$_PointDTOCopyWithImpl<$Res>
    extends _$PointDTOCopyWithImpl<$Res, _$_PointDTO>
    implements _$$_PointDTOCopyWith<$Res> {
  __$$_PointDTOCopyWithImpl(
      _$_PointDTO _value, $Res Function(_$_PointDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? address = freezed,
    Object? crossdockingId = freezed,
    Object? crossdockName = freezed,
    Object? crossdockLat = freezed,
    Object? crossdockLong = freezed,
    Object? status = freezed,
    Object? date = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? lat = freezed,
    Object? long = freezed,
    Object? type = freezed,
    Object? avatar = freezed,
    Object? countProducts = freezed,
    Object? pointType = freezed,
    Object? createdAt = freezed,
    Object? products = freezed,
    Object? containers = freezed,
  }) {
    return _then(_$_PointDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      crossdockingId: freezed == crossdockingId
          ? _value.crossdockingId
          : crossdockingId // ignore: cast_nullable_to_non_nullable
              as String?,
      crossdockName: freezed == crossdockName
          ? _value.crossdockName
          : crossdockName // ignore: cast_nullable_to_non_nullable
              as String?,
      crossdockLat: freezed == crossdockLat
          ? _value.crossdockLat
          : crossdockLat // ignore: cast_nullable_to_non_nullable
              as String?,
      crossdockLong: freezed == crossdockLong
          ? _value.crossdockLong
          : crossdockLong // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as String?,
      long: freezed == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as dynamic,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as dynamic,
      countProducts: freezed == countProducts
          ? _value.countProducts
          : countProducts // ignore: cast_nullable_to_non_nullable
              as int?,
      pointType: freezed == pointType
          ? _value.pointType
          : pointType // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductDTO>?,
      containers: freezed == containers
          ? _value._containers
          : containers // ignore: cast_nullable_to_non_nullable
              as List<ContainerDTO>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PointDTO implements _PointDTO {
  const _$_PointDTO(
      {required this.id,
      this.name,
      this.address,
      @JsonKey(name: 'crossdocking_id') this.crossdockingId,
      @JsonKey(name: 'crossdocking_name') this.crossdockName,
      @JsonKey(name: 'crossdocking_lat') this.crossdockLat,
      @JsonKey(name: 'crossdocking_long') this.crossdockLong,
      this.status,
      this.date,
      this.from,
      this.to,
      this.lat,
      this.long,
      this.type,
      this.avatar,
      @JsonKey(name: 'count_products') this.countProducts,
      @JsonKey(name: 'point_type') this.pointType,
      @JsonKey(name: 'created_at') this.createdAt,
      final List<ProductDTO>? products,
      final List<ContainerDTO>? containers})
      : _products = products,
        _containers = containers;

  factory _$_PointDTO.fromJson(Map<String, dynamic> json) =>
      _$$_PointDTOFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? address;
  @override
  @JsonKey(name: 'crossdocking_id')
  final String? crossdockingId;
  @override
  @JsonKey(name: 'crossdocking_name')
  final String? crossdockName;
  @override
  @JsonKey(name: 'crossdocking_lat')
  final String? crossdockLat;
  @override
  @JsonKey(name: 'crossdocking_long')
  final String? crossdockLong;
  @override
  final String? status;
  @override
  final DateTime? date;
  @override
  final String? from;
  @override
  final String? to;
  @override
  final String? lat;
  @override
  final String? long;
  @override
  final dynamic type;
  @override
  final dynamic avatar;
  @override
  @JsonKey(name: 'count_products')
  final int? countProducts;
  @override
  @JsonKey(name: 'point_type')
  final int? pointType;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final List<ProductDTO>? _products;
  @override
  List<ProductDTO>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ContainerDTO>? _containers;
  @override
  List<ContainerDTO>? get containers {
    final value = _containers;
    if (value == null) return null;
    if (_containers is EqualUnmodifiableListView) return _containers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PointDTO(id: $id, name: $name, address: $address, crossdockingId: $crossdockingId, crossdockName: $crossdockName, crossdockLat: $crossdockLat, crossdockLong: $crossdockLong, status: $status, date: $date, from: $from, to: $to, lat: $lat, long: $long, type: $type, avatar: $avatar, countProducts: $countProducts, pointType: $pointType, createdAt: $createdAt, products: $products, containers: $containers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PointDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.crossdockingId, crossdockingId) ||
                other.crossdockingId == crossdockingId) &&
            (identical(other.crossdockName, crossdockName) ||
                other.crossdockName == crossdockName) &&
            (identical(other.crossdockLat, crossdockLat) ||
                other.crossdockLat == crossdockLat) &&
            (identical(other.crossdockLong, crossdockLong) ||
                other.crossdockLong == crossdockLong) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.long, long) || other.long == long) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            (identical(other.countProducts, countProducts) ||
                other.countProducts == countProducts) &&
            (identical(other.pointType, pointType) ||
                other.pointType == pointType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._containers, _containers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        address,
        crossdockingId,
        crossdockName,
        crossdockLat,
        crossdockLong,
        status,
        date,
        from,
        to,
        lat,
        long,
        const DeepCollectionEquality().hash(type),
        const DeepCollectionEquality().hash(avatar),
        countProducts,
        pointType,
        createdAt,
        const DeepCollectionEquality().hash(_products),
        const DeepCollectionEquality().hash(_containers)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PointDTOCopyWith<_$_PointDTO> get copyWith =>
      __$$_PointDTOCopyWithImpl<_$_PointDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PointDTOToJson(
      this,
    );
  }
}

abstract class _PointDTO implements PointDTO {
  const factory _PointDTO(
      {required final int id,
      final String? name,
      final String? address,
      @JsonKey(name: 'crossdocking_id') final String? crossdockingId,
      @JsonKey(name: 'crossdocking_name') final String? crossdockName,
      @JsonKey(name: 'crossdocking_lat') final String? crossdockLat,
      @JsonKey(name: 'crossdocking_long') final String? crossdockLong,
      final String? status,
      final DateTime? date,
      final String? from,
      final String? to,
      final String? lat,
      final String? long,
      final dynamic type,
      final dynamic avatar,
      @JsonKey(name: 'count_products') final int? countProducts,
      @JsonKey(name: 'point_type') final int? pointType,
      @JsonKey(name: 'created_at') final String? createdAt,
      final List<ProductDTO>? products,
      final List<ContainerDTO>? containers}) = _$_PointDTO;

  factory _PointDTO.fromJson(Map<String, dynamic> json) = _$_PointDTO.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get address;
  @override
  @JsonKey(name: 'crossdocking_id')
  String? get crossdockingId;
  @override
  @JsonKey(name: 'crossdocking_name')
  String? get crossdockName;
  @override
  @JsonKey(name: 'crossdocking_lat')
  String? get crossdockLat;
  @override
  @JsonKey(name: 'crossdocking_long')
  String? get crossdockLong;
  @override
  String? get status;
  @override
  DateTime? get date;
  @override
  String? get from;
  @override
  String? get to;
  @override
  String? get lat;
  @override
  String? get long;
  @override
  dynamic get type;
  @override
  dynamic get avatar;
  @override
  @JsonKey(name: 'count_products')
  int? get countProducts;
  @override
  @JsonKey(name: 'point_type')
  int? get pointType;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  List<ProductDTO>? get products;
  @override
  List<ContainerDTO>? get containers;
  @override
  @JsonKey(ignore: true)
  _$$_PointDTOCopyWith<_$_PointDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductDTO _$ProductDTOFromJson(Map<String, dynamic> json) {
  return _ProductDTO.fromJson(json);
}

/// @nodoc
mixin _$ProductDTO {
  int get id => throw _privateConstructorUsedError;
  int? get point => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductDTOCopyWith<ProductDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDTOCopyWith<$Res> {
  factory $ProductDTOCopyWith(
          ProductDTO value, $Res Function(ProductDTO) then) =
      _$ProductDTOCopyWithImpl<$Res, ProductDTO>;
  @useResult
  $Res call({int id, int? point, String? name, String? code, String? status});
}

/// @nodoc
class _$ProductDTOCopyWithImpl<$Res, $Val extends ProductDTO>
    implements $ProductDTOCopyWith<$Res> {
  _$ProductDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? point = freezed,
    Object? name = freezed,
    Object? code = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      point: freezed == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductDTOCopyWith<$Res>
    implements $ProductDTOCopyWith<$Res> {
  factory _$$_ProductDTOCopyWith(
          _$_ProductDTO value, $Res Function(_$_ProductDTO) then) =
      __$$_ProductDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int? point, String? name, String? code, String? status});
}

/// @nodoc
class __$$_ProductDTOCopyWithImpl<$Res>
    extends _$ProductDTOCopyWithImpl<$Res, _$_ProductDTO>
    implements _$$_ProductDTOCopyWith<$Res> {
  __$$_ProductDTOCopyWithImpl(
      _$_ProductDTO _value, $Res Function(_$_ProductDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? point = freezed,
    Object? name = freezed,
    Object? code = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_ProductDTO(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      point: freezed == point
          ? _value.point
          : point // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductDTO implements _ProductDTO {
  const _$_ProductDTO(
      {required this.id, this.point, this.name, this.code, this.status});

  factory _$_ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ProductDTOFromJson(json);

  @override
  final int id;
  @override
  final int? point;
  @override
  final String? name;
  @override
  final String? code;
  @override
  final String? status;

  @override
  String toString() {
    return 'ProductDTO(id: $id, point: $point, name: $name, code: $code, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductDTO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.point, point) || other.point == point) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, point, name, code, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductDTOCopyWith<_$_ProductDTO> get copyWith =>
      __$$_ProductDTOCopyWithImpl<_$_ProductDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductDTOToJson(
      this,
    );
  }
}

abstract class _ProductDTO implements ProductDTO {
  const factory _ProductDTO(
      {required final int id,
      final int? point,
      final String? name,
      final String? code,
      final String? status}) = _$_ProductDTO;

  factory _ProductDTO.fromJson(Map<String, dynamic> json) =
      _$_ProductDTO.fromJson;

  @override
  int get id;
  @override
  int? get point;
  @override
  String? get name;
  @override
  String? get code;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$_ProductDTOCopyWith<_$_ProductDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

ContainerDTO _$ContainerDTOFromJson(Map<String, dynamic> json) {
  return _ContainerDTO.fromJson(json);
}

/// @nodoc
mixin _$ContainerDTO {
  @JsonKey(name: "id")
  int? get containerId => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  set containerId(int? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "point_id")
  int? get pointId => throw _privateConstructorUsedError;
  @JsonKey(name: "point_id")
  set pointId(int? value) => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  set createdAt(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  set updatedAt(String? value) => throw _privateConstructorUsedError;
  bool get isScanned => throw _privateConstructorUsedError;
  set isScanned(bool value) => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  set status(int? value) => throw _privateConstructorUsedError;
  bool get isSentAndStored => throw _privateConstructorUsedError;
  set isSentAndStored(bool value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContainerDTOCopyWith<ContainerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContainerDTOCopyWith<$Res> {
  factory $ContainerDTOCopyWith(
          ContainerDTO value, $Res Function(ContainerDTO) then) =
      _$ContainerDTOCopyWithImpl<$Res, ContainerDTO>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? containerId,
      @JsonKey(name: "point_id") int? pointId,
      String? code,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      bool isScanned,
      int? status,
      bool isSentAndStored});
}

/// @nodoc
class _$ContainerDTOCopyWithImpl<$Res, $Val extends ContainerDTO>
    implements $ContainerDTOCopyWith<$Res> {
  _$ContainerDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? containerId = freezed,
    Object? pointId = freezed,
    Object? code = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isScanned = null,
    Object? status = freezed,
    Object? isSentAndStored = null,
  }) {
    return _then(_value.copyWith(
      containerId: freezed == containerId
          ? _value.containerId
          : containerId // ignore: cast_nullable_to_non_nullable
              as int?,
      pointId: freezed == pointId
          ? _value.pointId
          : pointId // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isScanned: null == isScanned
          ? _value.isScanned
          : isScanned // ignore: cast_nullable_to_non_nullable
              as bool,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      isSentAndStored: null == isSentAndStored
          ? _value.isSentAndStored
          : isSentAndStored // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ContainerDTOCopyWith<$Res>
    implements $ContainerDTOCopyWith<$Res> {
  factory _$$_ContainerDTOCopyWith(
          _$_ContainerDTO value, $Res Function(_$_ContainerDTO) then) =
      __$$_ContainerDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? containerId,
      @JsonKey(name: "point_id") int? pointId,
      String? code,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      bool isScanned,
      int? status,
      bool isSentAndStored});
}

/// @nodoc
class __$$_ContainerDTOCopyWithImpl<$Res>
    extends _$ContainerDTOCopyWithImpl<$Res, _$_ContainerDTO>
    implements _$$_ContainerDTOCopyWith<$Res> {
  __$$_ContainerDTOCopyWithImpl(
      _$_ContainerDTO _value, $Res Function(_$_ContainerDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? containerId = freezed,
    Object? pointId = freezed,
    Object? code = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isScanned = null,
    Object? status = freezed,
    Object? isSentAndStored = null,
  }) {
    return _then(_$_ContainerDTO(
      containerId: freezed == containerId
          ? _value.containerId
          : containerId // ignore: cast_nullable_to_non_nullable
              as int?,
      pointId: freezed == pointId
          ? _value.pointId
          : pointId // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      isScanned: null == isScanned
          ? _value.isScanned
          : isScanned // ignore: cast_nullable_to_non_nullable
              as bool,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      isSentAndStored: null == isSentAndStored
          ? _value.isSentAndStored
          : isSentAndStored // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ContainerDTO implements _ContainerDTO {
  _$_ContainerDTO(
      {@JsonKey(name: "id") this.containerId,
      @JsonKey(name: "point_id") this.pointId,
      this.code,
      @JsonKey(name: "created_at") this.createdAt,
      @JsonKey(name: "updated_at") this.updatedAt,
      this.isScanned = false,
      this.status,
      this.isSentAndStored = false});

  factory _$_ContainerDTO.fromJson(Map<String, dynamic> json) =>
      _$$_ContainerDTOFromJson(json);

  @override
  @JsonKey(name: "id")
  int? containerId;
  @override
  @JsonKey(name: "point_id")
  int? pointId;
  @override
  String? code;
  @override
  @JsonKey(name: "created_at")
  String? createdAt;
  @override
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @override
  @JsonKey()
  bool isScanned;
  @override
  int? status;
  @override
  @JsonKey()
  bool isSentAndStored;

  @override
  String toString() {
    return 'ContainerDTO(containerId: $containerId, pointId: $pointId, code: $code, createdAt: $createdAt, updatedAt: $updatedAt, isScanned: $isScanned, status: $status, isSentAndStored: $isSentAndStored)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ContainerDTOCopyWith<_$_ContainerDTO> get copyWith =>
      __$$_ContainerDTOCopyWithImpl<_$_ContainerDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ContainerDTOToJson(
      this,
    );
  }
}

abstract class _ContainerDTO implements ContainerDTO {
  factory _ContainerDTO(
      {@JsonKey(name: "id") int? containerId,
      @JsonKey(name: "point_id") int? pointId,
      String? code,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      bool isScanned,
      int? status,
      bool isSentAndStored}) = _$_ContainerDTO;

  factory _ContainerDTO.fromJson(Map<String, dynamic> json) =
      _$_ContainerDTO.fromJson;

  @override
  @JsonKey(name: "id")
  int? get containerId;
  @JsonKey(name: "id")
  set containerId(int? value);
  @override
  @JsonKey(name: "point_id")
  int? get pointId;
  @JsonKey(name: "point_id")
  set pointId(int? value);
  @override
  String? get code;
  set code(String? value);
  @override
  @JsonKey(name: "created_at")
  String? get createdAt;
  @JsonKey(name: "created_at")
  set createdAt(String? value);
  @override
  @JsonKey(name: "updated_at")
  String? get updatedAt;
  @JsonKey(name: "updated_at")
  set updatedAt(String? value);
  @override
  bool get isScanned;
  set isScanned(bool value);
  @override
  int? get status;
  set status(int? value);
  @override
  bool get isSentAndStored;
  set isSentAndStored(bool value);
  @override
  @JsonKey(ignore: true)
  _$$_ContainerDTOCopyWith<_$_ContainerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
