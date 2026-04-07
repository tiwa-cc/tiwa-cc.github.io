import 'dart:io';

import 'package:my_portfolio/app/interface/api_repository_interface.dart';
import 'package:my_portfolio/app/interface/api_response.dart';
import 'package:my_portfolio/infrastructure/communicate/sever_api_interface.dart';

final class ApiRepository implements ApiRepositoryInterface {
  final SeverApiInterface _api;

  ApiRepository({required SeverApiInterface api}) : _api = api;

  @override
  Future<ApiResponse> fetchAbout() async {
    final request = AboutRequest();
    final apiResponse = _api.aboutIndex(request).then((response) {
      return ApiResponse(status: HttpStatus.ok, response: response);
    });
    return apiResponse;
  }

  @override
  Future<ApiResponse> fetchAllContents() async {
    final request = ContentRequest();
    final apiResponse = _api.contentIndex(request).then((response) {
      return ApiResponse(status: HttpStatus.ok, response: response);
    });
    return apiResponse;
  }

  @override
  Future<ApiResponse> fetchAllCoreSkills() async {
    final request = CoreSkillRequest();
    final apiResponse = _api.coreSkillIndex(request).then((response) {
      return ApiResponse(status: HttpStatus.ok, response: response);
    });
    return apiResponse;
  }

  @override
  Future<ApiResponse> fetchAllSoftwareSkills() async {
    final request = SoftwareSkillRequest();
    final apiResponse = _api.softwareSkillIndex(request).then((response) {
      return ApiResponse(status: HttpStatus.ok, response: response);
    });
    return apiResponse;
  }

  @override
  Future<ApiResponse> fetchAllExperiences() async {
    final request = ExperienceRequest();
    final apiResponse = _api.experienceIndex(request).then((response) {
      return ApiResponse(status: HttpStatus.ok, response: response);
    });
    return apiResponse;
  }
}
