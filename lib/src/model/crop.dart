import 'package:flutter_sanity_image_url/src/model/reference_data.dart';

/// A Crop for an Image.
/// Based on cropping values from left, right, top and bottom.
class Crop {
  Crop(
      {required this.bottom,
      required this.left,
      required this.right,
      required this.top});

  double left;
  double right;
  double top;
  double bottom;

  /// Converts the crop data from left, right top and bottom.
  /// to left and top relative with width and height values.
  LTWH toImageCoordinates(ReferenceData asset) {
    final cropLeft = (left * asset.width).round();
    final cropTop = (top * asset.height).round();

    return LTWH(
        cropLeft,
        cropTop,
        (asset.width - right * asset.width - cropLeft).round(),
        (asset.height - bottom * asset.height - cropTop).round());
  }

  /// Parses [json] into a Crop object.
  static Crop fromJson(Map<String, dynamic> json) {
    return Crop(
        left: double.tryParse(json['left'].toString()) ?? 0,
        top: double.tryParse(json['top'].toString()) ?? 0,
        right: double.tryParse(json['right'].toString()) ?? 0,
        bottom: double.tryParse(json['bottom'].toString()) ?? 0);
  }
}

/// A grouping of left, top, width and height values.
class LTWH {
  LTWH(this.left, this.top, this.width, this.height);

  int left;
  int top;
  int width;
  int height;
}
