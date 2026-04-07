import 'package:my_portfolio/domain/about.dart';
import 'package:my_portfolio/domain/content_entry.dart';
import 'package:my_portfolio/domain/core_skill.dart';
import 'package:my_portfolio/domain/experience.dart';
import 'package:my_portfolio/domain/software_skill.dart';
import 'package:my_portfolio/infrastructure/storage/storage_access_interface.dart';

class DBAccessor implements StorageAccessInterface {
  /// INFO: 本来はDriftなどの実装を行う
  DBAccessor();

  @override
  Stream<About> watchAbout() {
    throw UnimplementedError();
  }

  @override
  Stream<List<ContentEntry>> watchContentEntryList() {
    throw UnimplementedError();
  }

  @override
  Stream<List<CoreSkill>> watchCoreSkillList() {
    throw UnimplementedError();
  }

  @override
  Stream<List<SoftwareSkill>> watchSoftwareSkillList() {
    throw UnimplementedError();
  }

  @override
  Stream<List<Experience>> watchExperienceList() {
    throw UnimplementedError();
  }

  @override
  Stream<void> insertOrUpdateAbout(About entity) {
    throw UnimplementedError();
  }

  @override
  Stream<void> insertOrUpdateContentEntry(ContentEntry entity) {
    throw UnimplementedError();
  }

  @override
  Stream<void> insertOrUpdateCoreSkill(CoreSkill entity) {
    throw UnimplementedError();
  }

  @override
  Stream<void> insertOrUpdateSoftwareSkill(SoftwareSkill entity) {
    throw UnimplementedError();
  }

  @override
  Stream<void> insertOrUpdateExperience(Experience entity) {
    throw UnimplementedError();
  }

  @override
  void replaceAbout(About entity) {
    throw UnimplementedError();
  }

  @override
  void replaceContentEntryList(List<ContentEntry> entities) {
    throw UnimplementedError();
  }

  @override
  void replaceCoreSkillList(List<CoreSkill> entities) {
    throw UnimplementedError();
  }

  @override
  void replaceSoftwareSkillList(List<SoftwareSkill> entities) {
    throw UnimplementedError();
  }

  @override
  void replaceExperienceList(List<Experience> entities) {
    throw UnimplementedError();
  }
}
