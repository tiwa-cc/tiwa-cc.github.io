import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience.freezed.dart';
part 'experience.g.dart';

@Freezed(fromJson: true)
abstract class Experience with _$Experience {
  const factory Experience({
    required String title,
    required String summary,
    required String startedAt,
    required String endedAt,
    required List<String> highlights,
    required List<String> technologies,
  }) = _Experience;

  factory Experience.fromJson(Map<String, Object?> json) =>
      _$ExperienceFromJson(json);
}

extension ExperienceExt on Experience {
  static get empty => Experience(
    title: '',
    summary: '',
    startedAt: '',
    endedAt: '',
    highlights: [],
    technologies: [],
  );
}
