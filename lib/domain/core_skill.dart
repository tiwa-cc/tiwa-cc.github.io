import 'package:freezed_annotation/freezed_annotation.dart';

part 'core_skill.freezed.dart';
part 'core_skill.g.dart';

@Freezed(fromJson: true)
abstract class CoreSkill with _$CoreSkill {
  const factory CoreSkill({
    required String title,
    required String description,
  }) = _CoreSkill;

  factory CoreSkill.fromJson(Map<String, Object?> json) =>
      _$CoreSkillFromJson(json);
}
