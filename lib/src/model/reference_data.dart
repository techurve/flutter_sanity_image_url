class ReferenceData {
  ReferenceData(this.id, this.width, this.height, this.format);

  String id;
  int width;
  int height;
  String format;

  get filename {
    return '$id-${width}x$height.$format';
  }
}
