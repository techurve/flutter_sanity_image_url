import 'package:flutter_sanity_image_url/src/model/reference_data.dart';

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

  LTWH toImageCoordinates(ReferenceData asset) {
    final cropLeft = (left * asset.width).round();
    final cropTop = (top * asset.height).round();

    return LTWH(
        cropLeft,
        cropTop,
        (asset.width - right * asset.width - cropLeft).round(),
        (asset.height - bottom * asset.height - cropTop).round());
  }

  static Crop fromJson(Map<String, dynamic> json) {
    return Crop(
        left: double.tryParse(json['left'].toString()) ?? 0,
        top: double.tryParse(json['top'].toString()) ?? 0,
        right: double.tryParse(json['right'].toString()) ?? 0,
        bottom: double.tryParse(json['bottom'].toString()) ?? 0);
  }
}

class LTWH {
  LTWH(this.left, this.top, this.width, this.height);

  int left;
  int top;
  int width;
  int height;
}
