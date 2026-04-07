import 'dart:async';

import 'package:my_portfolio/domain/about.dart';
import 'package:my_portfolio/domain/content_entry.dart';
import 'package:my_portfolio/domain/core_skill.dart';
import 'package:my_portfolio/domain/experience.dart';
import 'package:my_portfolio/domain/software_skill.dart';
import 'package:my_portfolio/infrastructure/storage/storage_access_interface.dart';

class RawAccessor implements StorageAccessInterface {
  RawAccessor() {
    _aboutController = StreamController<About>.broadcast();
    _contentEntriesController =
        StreamController<List<ContentEntry>>.broadcast();
    _coreSkillsController = StreamController<List<CoreSkill>>.broadcast();
    _softwareSkillsController =
        StreamController<List<SoftwareSkill>>.broadcast();
    _experiencesController = StreamController<List<Experience>>.broadcast();
    _about = AboutExt.empty;
    _contentEntryList = [];
    _coreSkillList = [];
    _softwareSkillList = [];
    _experienceList = [];
  }

  late final StreamController<About> _aboutController;
  late final StreamController<List<ContentEntry>> _contentEntriesController;
  late final StreamController<List<CoreSkill>> _coreSkillsController;
  late final StreamController<List<SoftwareSkill>> _softwareSkillsController;
  late final StreamController<List<Experience>> _experiencesController;
  late About _about;
  late List<ContentEntry> _contentEntryList;
  late List<CoreSkill> _coreSkillList;
  late List<SoftwareSkill> _softwareSkillList;
  late List<Experience> _experienceList;
  var _hasAbout = false;
  var _hasContentEntryList = false;
  var _hasCoreSkillList = false;
  var _hasSoftwareSkillList = false;
  var _hasExperienceList = false;

  @override
  Stream<About> watchAbout() => _watchCurrentValue(
    current: _about,
    hasValue: _hasAbout,
    stream: _aboutController.stream,
  );

  @override
  Stream<List<ContentEntry>> watchContentEntryList() => _watchCurrentValue(
    current: _contentEntryList,
    hasValue: _hasContentEntryList,
    stream: _contentEntriesController.stream,
  );

  @override
  Stream<List<CoreSkill>> watchCoreSkillList() => _watchCurrentValue(
    current: _coreSkillList,
    hasValue: _hasCoreSkillList,
    stream: _coreSkillsController.stream,
  );

  @override
  Stream<List<SoftwareSkill>> watchSoftwareSkillList() => _watchCurrentValue(
    current: _softwareSkillList,
    hasValue: _hasSoftwareSkillList,
    stream: _softwareSkillsController.stream,
  );

  @override
  Stream<List<Experience>> watchExperienceList() => _watchCurrentValue(
    current: _experienceList,
    hasValue: _hasExperienceList,
    stream: _experiencesController.stream,
  );

  @override
  Stream<void> insertOrUpdateAbout(About entity) {
    _about = entity;
    _hasAbout = true;
    _aboutController.add(_about);
    return Stream.value(null);
  }

  @override
  Stream<void> insertOrUpdateContentEntry(ContentEntry entity) {
    _contentEntryList.add(entity);
    _hasContentEntryList = true;
    _contentEntriesController.add(List.unmodifiable(_contentEntryList));
    return Stream.value(null);
  }

  @override
  Stream<void> insertOrUpdateCoreSkill(CoreSkill entity) {
    _coreSkillList.add(entity);
    _hasCoreSkillList = true;
    _coreSkillsController.add(List.unmodifiable(_coreSkillList));
    return Stream.value(null);
  }

  @override
  Stream<void> insertOrUpdateSoftwareSkill(SoftwareSkill entity) {
    _softwareSkillList.add(entity);
    _hasSoftwareSkillList = true;
    _softwareSkillsController.add(List.unmodifiable(_softwareSkillList));
    return Stream.value(null);
  }

  @override
  Stream<void> insertOrUpdateExperience(Experience entity) {
    _experienceList.add(entity);
    _hasExperienceList = true;
    _experiencesController.add(List.unmodifiable(_experienceList));
    return Stream.value(null);
  }

  @override
  void replaceAbout(About entity) {
    _about = entity;
    _hasAbout = true;
    _aboutController.add(_about);
  }

  @override
  void replaceContentEntryList(List<ContentEntry> entities) {
    _contentEntryList = List.unmodifiable(entities);
    _hasContentEntryList = true;
    _contentEntriesController.add(_contentEntryList);
  }

  @override
  void replaceCoreSkillList(List<CoreSkill> entities) {
    _coreSkillList = List.unmodifiable(entities);
    _hasCoreSkillList = true;
    _coreSkillsController.add(_coreSkillList);
  }

  @override
  void replaceSoftwareSkillList(List<SoftwareSkill> entities) {
    _softwareSkillList = List.unmodifiable(entities);
    _hasSoftwareSkillList = true;
    _softwareSkillsController.add(_softwareSkillList);
  }

  @override
  void replaceExperienceList(List<Experience> entities) {
    _experienceList = List.unmodifiable(entities);
    _hasExperienceList = true;
    _experiencesController.add(_experienceList);
  }

  Stream<T> _watchCurrentValue<T>({
    required T current,
    required bool hasValue,
    required Stream<T> stream,
  }) async* {
    if (hasValue) {
      yield current;
    }
    yield* stream;
  }
}
