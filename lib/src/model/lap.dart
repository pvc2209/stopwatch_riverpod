import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

class Lap extends Equatable {
  final String id;
  final int elapsed; // in milliseconds
  final String name;

  const Lap({
    required this.id,
    required this.elapsed,
    required this.name,
  });

  factory Lap.create({
    required int elapsed,
    required String name,
  }) {
    return Lap(
      id: _uuid.v1(),
      elapsed: elapsed,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'elapsed': elapsed,
      'name': name,
    };
  }

  factory Lap.fromMap(Map<String, dynamic> map) {
    return Lap(
      id: map['id'],
      elapsed: map['elapsed']?.toInt(),
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lap.fromJson(String source) => Lap.fromMap(json.decode(source));

  Lap copyWith({
    String? id,
    int? elapsed,
    String? name,
  }) {
    return Lap(
      id: id ?? this.id,
      elapsed: elapsed ?? this.elapsed,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [id, elapsed, name];
}
