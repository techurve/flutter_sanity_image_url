/// Reference Data for an Image.
class ReferenceData {
  ReferenceData(this.id, this.width, this.height, this.format);

  String id;
  int width;
  int height;
  String format;

  /// gets the correctly formatted filename String for use in an image url.
  String get filename {
    return '$id-${width}x$height.$format';
  }
}
