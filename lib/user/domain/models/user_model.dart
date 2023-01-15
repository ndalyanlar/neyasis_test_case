import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name, surname, identity, phoneNumber, id;

  final double salary;

  @_Iso8691DateTimeConverter()
  final DateTime birthDate;

  UserModel({
    required this.name,
    required this.surname,
    required this.identity,
    required this.phoneNumber,
    required this.id,
    required this.salary,
    required this.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? name,
    surname,
    identity,
    phoneNumber,
    id,
    double? salary,
    DateTime? birthDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      salary: salary ?? this.salary,
      birthDate: birthDate ?? this.birthDate,
      surname: surname ?? this.surname,
      identity: identity ?? this.identity,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
    );
  }
}

class _Iso8691DateTimeConverter implements JsonConverter<DateTime, String> {
  const _Iso8691DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}
