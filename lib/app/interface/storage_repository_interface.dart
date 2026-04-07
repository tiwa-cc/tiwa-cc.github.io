import 'package:my_portfolio/domain/experience.dart';

abstract interface class StorageRepositoryInterface {
  Future<List<Experience>> indexAllExperiences();
  Future<Experience> showExperiences();
  Future<void> updateExperiences(Experience entity);
  Future<void> destroyExperiences(int entityId);
}
