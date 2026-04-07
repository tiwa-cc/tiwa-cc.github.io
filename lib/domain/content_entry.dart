import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_entry.freezed.dart';
part 'content_entry.g.dart';

@Freezed(fromJson: true)
abstract class ContentEntry with _$ContentEntry {
  const factory ContentEntry({
    required String title,
    required String summary,
    required List<String> tags,
    required List<String> details,
    required List<ContentLink> links,
  }) = _ContentEntry;

  factory ContentEntry.fromJson(Map<String, Object?> json) =>
      _$ContentEntryFromJson(json);
}

@Freezed(fromJson: true)
abstract class ContentLink with _$ContentLink {
  const factory ContentLink({
    required String label,
    required String url,
    required String kind,
  }) = _ContentLink;

  factory ContentLink.fromJson(Map<String, Object?> json) =>
      _$ContentLinkFromJson(json);
}
