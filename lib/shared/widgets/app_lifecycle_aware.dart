import 'package:flutter/material.dart';

/// A widget that is aware of the application's lifecycle events.
///
/// This widget can be used to perform actions or trigger logic when the app
/// enters different lifecycle states, such as paused, resumed, or inactive.
/// Useful for managing resources, saving state, or handling background tasks
/// in response to lifecycle changes.
class AppLifecycleAware extends StatefulWidget {
  final void Function()? onResume;
  final void Function()? onPause;
  final Widget child;

  const AppLifecycleAware({
    super.key,
    this.onResume,
    this.onPause,
    required this.child,
  });

  @override
  State<AppLifecycleAware> createState() => _AppLifecycleAwareState();
}

class _AppLifecycleAwareState extends State<AppLifecycleAware>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.onResume?.call();
        break;
      case AppLifecycleState.paused:
        widget.onPause?.call();
        break;
      default:
        break;
    }
  }
}
