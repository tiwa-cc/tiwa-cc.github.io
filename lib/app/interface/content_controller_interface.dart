import 'package:my_portfolio/app/interface/api_repository_interface.dart';
import 'package:my_portfolio/app/interface/api_response.dart';

abstract interface class ContentControllerInterface {
  Future<ApiResponse> create();
  Future<ApiResponse> index();
  Future<ApiResponse> show(int id);
  Future<ApiResponse> update(int id);
  Future<ApiResponse> destroy(int id);
}

final class ContentController implements ContentControllerInterface {
  final ApiRepositoryInterface _apiRepo;

  ContentController({required ApiRepositoryInterface apiRepo})
    : _apiRepo = apiRepo;

  @override
  Future<ApiResponse> create() {
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> index() async {
    final result = await _apiRepo.fetchAllContents();
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
