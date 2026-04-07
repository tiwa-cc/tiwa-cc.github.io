import 'package:freezed_annotation/freezed_annotation.dart';

part 'about.freezed.dart';
part 'about.g.dart';

@Freezed(fromJson: true)
abstract class About with _$About {
  const factory About({required List<String> paragraphs}) = _About;

  factory About.fromJson(Map<String, Object?> json) => _$AboutFromJson(json);
}

extension AboutExt on About {
  static About get empty => const About(paragraphs: []);

  bool get isEmpty => paragraphs.every((paragraph) => paragraph.trim().isEmpty);
}
