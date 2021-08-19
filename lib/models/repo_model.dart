import 'package:json_annotation/json_annotation.dart';

part 'repo_model.g.dart';

@JsonSerializable()
class Repo {
  final String name;
  @JsonKey(includeIfNull: true, name: 'full_name')
  final String? fullName;
  @JsonKey(includeIfNull: true)
  final String? description;

  Repo(this.name, this.fullName, this.description);

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);
  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
