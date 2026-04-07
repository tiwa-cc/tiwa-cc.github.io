import 'package:my_portfolio/app/interface/api_response.dart';

abstract interface class ApiRepositoryInterface {
  Future<ApiResponse> fetchAbout();
  Future<ApiResponse> fetchAllContents();
  Future<ApiResponse> fetchAllCoreSkills();
  Future<ApiResponse> fetchAllSoftwareSkills();
  Future<ApiResponse> fetchAllExperiences();
}
