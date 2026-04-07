import 'package:my_portfolio/app/interface/api_repository_interface.dart';
import 'package:my_portfolio/app/interface/api_response.dart';

abstract interface class CoreSkillControllerInterface {
  Future<ApiResponse> create();
  Future<ApiResponse> index();
  Future<ApiResponse> show(int id);
  Future<ApiResponse> update(int id);
  Future<ApiResponse> destroy(int id);
}

final class CoreSkillController implements CoreSkillControllerInterface {
  final ApiRepositoryInterface _apiRepo;

  CoreSkillController({required ApiRepositoryInterface apiRepo})
    : _apiRepo = apiRepo;

  @override
  Future<ApiResponse> create() {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> index() async {
    final result = await _apiRepo.fetchAllCoreSkills();
    return result;
  }

  @override
  Future<ApiResponse> show(int id) {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> update(int id) {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> destroy(int id) {
    throw UnimplementedError();
  }
}
