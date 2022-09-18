import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';
part 'data.g.dart';

@freezed
class Data with _$Data {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Data({
    required String id,
    required String title,
    required String content,
    String? image,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
