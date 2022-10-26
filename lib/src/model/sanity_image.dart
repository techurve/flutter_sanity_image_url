import 'package:flutter_sanity_image_url/src/model/sanity_asset.dart';

class SanityImage {
  const SanityImage({
    required this.asset,
    required this.ref,
    this.crop,
    this.hotspot,
  });

  final SanityAsset asset;
  final String ref;
  final Map<String, dynamic>? crop;
  final Map<String, dynamic>? hotspot;

  static SanityImage fromJson(json) {
    return SanityImage(
      asset: json['asset'],
      ref: json['image']['_ref'],
      crop: json['image']?['crop'],
      hotspot: json['image']?['hotspot'],
    );
  }
}
