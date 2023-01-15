// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      surname: json['surname'] as String,
      identity: json['identity'] as String,
      phoneNumber: json['phoneNumber'] as String,
      id: json['id'] as String,
      salary: (json['salary'] as num).toDouble(),
      birthDate: const _Iso8691DateTimeConverter()
          .fromJson(json['birthDate'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'identity': instance.identity,
      'phoneNumber': instance.phoneNumber,
      'id': instance.id,
      'salary': instance.salary,
      'birthDate': const _Iso8691DateTimeConverter().toJson(instance.birthDate),
    };
