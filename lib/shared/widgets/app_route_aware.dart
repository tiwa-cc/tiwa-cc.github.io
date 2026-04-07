import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/shared/providers.dart';

/// A shared widget for route awareness within the application.
/// This file is intended to provide utilities or components that
/// help track navigation events or changes in app routes.
class AppRouteAware extends ConsumerStatefulWidget {
  final void Function()? didPop;
  final void Function()? didPopNext;
  final void Function()? didPush;
  final void Function()? didPushNext;
  final Widget child;

  const AppRouteAware({
    super.key,
    this.didPop,
    this.didPopNext,
    this.didPush,
    this.didPushNext,
    required this.child,
  });

  @override
  ConsumerState<AppRouteAware> createState() => _AppRouteAwareState();
}

class _AppRouteAwareState extends ConsumerState<AppRouteAware> with RouteAware {
  late final RouteObserver<ModalRoute<void>> routeObserver;

  @override
  void initState() {
    super.initState();
    routeObserver = ref.read(routeObserverProvider);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void didPop() {
    widget.didPop?.call();
  }

  @override
  void didPopNext() {
    widget.didPopNext?.call();
  }

  @override
  void didPush() {
    widget.didPush?.call();
  }

  @override
  void didPushNext() {
    widget.didPushNext?.call();
  }
}
