import 'package:my_portfolio/app/interface/api_repository_interface.dart';
import 'package:my_portfolio/app/interface/api_response.dart';

abstract interface class ExperienceControllerInterface {
  Future<ApiResponse> create();
  Future<ApiResponse> index();
  Future<ApiResponse> show(int id);
  Future<ApiResponse> update(int id);
  Future<ApiResponse> destroy(int id);
}

final class ExperienceController implements ExperienceControllerInterface {
  final ApiRepositoryInterface _apiRepo;

  ExperienceController({required ApiRepositoryInterface apiRepo})
    : _apiRepo = apiRepo;

  @override
  Future<ApiResponse> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> index() async {
    final result = await _apiRepo.fetchAllExperiences();
    return result;
  }

  @override
  Future<ApiResponse> show(int id) {
    // TODO: implement show
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> update(int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> destroy(int id) {
    // TODO: implement destroy
    throw UnimplementedError();
  }
}
