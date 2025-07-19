import 'package:flutter/material.dart';

class CustomScrollSpyListView<T extends Enum> extends StatefulWidget {
  final Map<T, Widget> sections;
  final ValueChanged<T> onSectionChanged;

  const CustomScrollSpyListView({
    super.key,
    required this.sections,
    required this.onSectionChanged,
  });

  @override
  State<CustomScrollSpyListView<T>> createState() =>
      _CustomScrollSpyListViewState<T>();
}

class _CustomScrollSpyListViewState<T extends Enum>
    extends State<CustomScrollSpyListView<T>> {
  final _scrollController = ScrollController();
  final _sectionKeys = <T, GlobalKey>{};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    for (final section in widget.sections.keys) {
      _sectionKeys[section] = GlobalKey();
    }
  }

  void scrollTo(T section) {
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
          widget.onSectionChanged(entry.key);
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: widget.sections.entries.map((entry) {
        return Container(key: _sectionKeys[entry.key], child: entry.value);
      }).toList(),
    );
  }
}
