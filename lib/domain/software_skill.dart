import 'package:freezed_annotation/freezed_annotation.dart';

part 'software_skill.freezed.dart';
part 'software_skill.g.dart';

@Freezed(fromJson: true)
abstract class SoftwareSkill with _$SoftwareSkill {
  const factory SoftwareSkill({required String id, required String label}) =
      _SoftwareSkill;

  factory SoftwareSkill.fromJson(Map<String, Object?> json) =>
      _$SoftwareSkillFromJson(json);
}
