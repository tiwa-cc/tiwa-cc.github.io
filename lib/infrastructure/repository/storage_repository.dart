import 'package:my_portfolio/app/interface/storage_repository_interface.dart';
import 'package:my_portfolio/domain/experience.dart';
import 'package:my_portfolio/infrastructure/storage/db_accessor.dart';
import 'package:my_portfolio/infrastructure/storage/storage_access_interface.dart';

final class StorageRepository implements StorageRepositoryInterface {
  final StorageAccessInterface _storage;

  StorageRepository({required StorageAccessInterface? storage})
    : _storage = storage ?? DBAccessor();

  @override
  Future<List<Experience>> indexAllExperiences() {
    return _storage.watchExperienceList().single;
  }

  @override
  Future<Experience> showExperiences() {
    final entity = ExperienceExt.empty;
    _storage.insertOrUpdateExperience(entity);
    return entity;
  }

  @override
  Future<void> updateExperiences(Experience entity) {
    return Future.value();
  }

  @override
  Future<void> destroyExperiences(int entityId) {
    return Future.value();
  }
}
