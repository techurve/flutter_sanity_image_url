import 'package:flutter_sanity_image_url/src/model/reference_data.dart';

import 'crop.dart';

class Hotspot {
  Hotspot(this.height, this.width, this.x, this.y);

  final int height;
  final int width;
  final double x;
  final double y;

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
}
