import 'package:flutter/material.dart';

/// A mixin that provides scroll jumping functionality for sections.
mixin ScrollJumper<T extends Enum> {
  final _scrollController = ScrollController();
  var _sectionKeys = <T, GlobalKey>{};
  void Function(T section)? _onSectionChanged;

  /// The scroll controller for the scroll view.
  get scrollController => _scrollController;

  /// The keys for the sections.
  set setOnSectionChanged(void Function(T section) onSectionChanged) {
    _onSectionChanged = onSectionChanged;
  }

  /// Sets the section keys for the scroll jumper.
  set setSectionKeys(List<T> sections) {
    _sectionKeys = sections.asMap().map(
      (index, section) => MapEntry(section, GlobalKey()),
    );
  }

  /// Gets the global key for the specified section.
  GlobalKey? globalKeyWithSection(T section) {
    return _sectionKeys[section];
  }

  /// Initializes the scroll jumper with sections and an optional section change handler.
  void initScrollJumper(
    List<T> sections,
    void Function(T section)? onSectionChanged,
  ) {
    _scrollController.addListener(_handleScroll);

    setSectionKeys = sections;
    setOnSectionChanged = onSectionChanged ?? (section) {};
  }

  /// Disposes the scroll controller and removes the scroll listener.
  void disposeScrollJumper() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
  }

  /// Scrolls to the top of the scroll view.
  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  /// Scrolls to the specified section.
  void scrollToSection(T section) {
    final key = _sectionKeys[section];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleScroll() {
    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final pos = box.localToGlobal(Offset.zero).dy;
        if (pos < 200 && pos > -200) {
          _onSectionChanged?.call(entry.key);
          break;
        }
      }
    }
  }
}
