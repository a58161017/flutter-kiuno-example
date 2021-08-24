import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(required: true)
  String name;

  @JsonKey(defaultValue: 'none@123.com')
  String email;

  @JsonKey(ignore: true)
  String? headshot;

  User(this.name, this.email);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
