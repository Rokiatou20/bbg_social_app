import 'package:json_annotation/json_annotation.dart';
import 'package:test_drive/data/models/authorization/authorization.dart';
import 'package:test_drive/data/models/user/user.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  User? user;
  Authorization? authorization;

  Session({this.user, this.authorization});

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  /*Session.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    authorization = json['authorization'] != null ? Authorization.fromJson(json['authorization']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (authorization != null) {
      data['authorization'] = authorization!.toJson();
    }
    return data;
  }*/
}
