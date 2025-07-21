import 'package:flutter/material.dart';

class TopViewHolder {
  final GlobalKey skillGlobalKey;
  final GlobalKey profileGlobalKey;
  final GlobalKey aboutGlobalKey;
  final GlobalKey portfolioGlobalKey;
  final GlobalKey contactGlobalKey;
  final Function() scrollViewHeader;
  const TopViewHolder({
    required this.skillGlobalKey,
    required this.profileGlobalKey,
    required this.aboutGlobalKey,
    required this.portfolioGlobalKey,
    required this.contactGlobalKey,
    required this.scrollViewHeader,
  });
}
