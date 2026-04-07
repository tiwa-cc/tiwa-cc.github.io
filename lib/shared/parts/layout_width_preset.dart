enum LayoutWidthPreset {
  auto(null, 'Auto'),
  xs(375, 'XS'),
  sm(768, 'SM'),
  md(1024, 'MD'),
  lg(1280, 'LG'),
  xl(1600, 'XL');

  const LayoutWidthPreset(this.width, this.label);

  final double? width;
  final String label;

  String get menuLabel =>
      width == null ? label : '$label (${width!.toInt()}px)';
}
