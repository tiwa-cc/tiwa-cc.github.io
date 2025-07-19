final class MediaQueryTool {
  static double ratioWidth(
    double mediaHeight,
    double mediaWidth,
    double targetHeight,
  ) {
    final targetWidth = targetHeight * mediaWidth / mediaHeight;
    return targetWidth;
  }
}
