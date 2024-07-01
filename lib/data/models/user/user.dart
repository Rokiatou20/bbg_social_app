import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  @JsonKey(name: 'first_name')
  String? firstName; //first_name
  @JsonKey(name: 'last_name')
  String? lastName; //last_name
  String? email;
  String? password;
  String? photo;
  @JsonKey(name: 'created_at')
  DateTime? createdAt; //created_at
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt; //updated_at
  @JsonKey(name: 'deleted_at')
  DateTime? deletedAt; //deleted_at

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
    }
  );

  /// Connect the generated [_$UserFromJson] function to the `fromJson`
  /// factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

/*User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    photo = json['photo'];
    createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    deletedAt = json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'photo': photo,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }*/
}