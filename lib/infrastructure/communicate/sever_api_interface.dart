import 'package:json_annotation/json_annotation.dart';

part 'sever_api_interface.g.dart';

abstract interface class SeverApiInterface {
  Future<AboutResponse> aboutIndex(AboutRequest request);
  Future<ContentResponse> contentIndex(ContentRequest request);
  Future<CoreSkillResponse> coreSkillIndex(CoreSkillRequest request);
  Future<SoftwareSkillResponse> softwareSkillIndex(
    SoftwareSkillRequest request,
  );
  Future<ExperienceResponse> experienceIndex(ExperienceRequest request);
}

@JsonSerializable()
class AboutRequest {
  AboutRequest();
  factory AboutRequest.fromJson(Map<String, dynamic> json) =>
      _$AboutRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AboutRequestToJson(this);
}

@JsonSerializable()
class AboutResponse {
  final int id;
  AboutResponse({required this.id});
  factory AboutResponse.fromJson(Map<String, dynamic> json) =>
      _$AboutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AboutResponseToJson(this);
}

@JsonSerializable()
class ContentRequest {
  ContentRequest();
  factory ContentRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ContentRequestToJson(this);
}

@JsonSerializable()
class ContentResponse {
  final int id;
  ContentResponse({required this.id});
  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);
}

@JsonSerializable()
class CoreSkillRequest {
  CoreSkillRequest();
  factory CoreSkillRequest.fromJson(Map<String, dynamic> json) =>
      _$CoreSkillRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CoreSkillRequestToJson(this);
}

@JsonSerializable()
class CoreSkillResponse {
  final int id;
  CoreSkillResponse({required this.id});
  factory CoreSkillResponse.fromJson(Map<String, dynamic> json) =>
      _$CoreSkillResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CoreSkillResponseToJson(this);
}

@JsonSerializable()
class SoftwareSkillRequest {
  SoftwareSkillRequest();
  factory SoftwareSkillRequest.fromJson(Map<String, dynamic> json) =>
      _$SoftwareSkillRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SoftwareSkillRequestToJson(this);
}

@JsonSerializable()
class SoftwareSkillResponse {
  final int id;
  SoftwareSkillResponse({required this.id});
  factory SoftwareSkillResponse.fromJson(Map<String, dynamic> json) =>
      _$SoftwareSkillResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SoftwareSkillResponseToJson(this);
}

@JsonSerializable()
class ExperienceRequest {
  ExperienceRequest();
  factory ExperienceRequest.fromJson(Map<String, dynamic> json) =>
      _$ExperienceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceRequestToJson(this);
}

@JsonSerializable()
class ExperienceResponse {
  final int id;
  ExperienceResponse({required this.id});
  factory ExperienceResponse.fromJson(Map<String, dynamic> json) =>
      _$ExperienceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceResponseToJson(this);
}
