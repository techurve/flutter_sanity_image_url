import 'package:flutter_sanity_image_url/src/model/reference_data.dart';

import 'crop.dart';

/// An area on the image which should be shown to users, specified by content editors.
class Hotspot {
  Hotspot(this.height, this.width, this.x, this.y);

  final double height;
  final double width;
  final double x;
  final double y;

  /// Maps this hotspot to the [asset] and returns a [Crop] to be used.
  Crop toImageCoordinates(ReferenceData asset) {
    final hotSpotVerticalRadius = (height * asset.height) / 2;
    final hotSpotHorizontalRadius = (width * asset.width) / 2;
    final hotSpotCenterX = x * asset.width;
    final hotSpotCenterY = y * asset.height;

    return Crop(
        bottom: hotSpotCenterY + hotSpotVerticalRadius,
        left: hotSpotCenterX - hotSpotHorizontalRadius,
        right: hotSpotCenterX + hotSpotHorizontalRadius,
        top: hotSpotCenterY - hotSpotVerticalRadius);
  }

  /// creates a [Hotspot] object from the passed [json].
  static Hotspot fromJson(Map<String, dynamic> json) {
    return Hotspot(
        double.tryParse(json['height'].toString()) ?? 1,
        double.tryParse(json['width'].toString()) ?? 1,
        json['x'] ?? 0.5,
        json['y'] ?? 0.5);
  }
}
