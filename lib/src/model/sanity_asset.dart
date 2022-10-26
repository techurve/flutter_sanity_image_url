import 'package:flutter_sanity_image_url/src/model/sanity_image.dart';
import 'package:flutter_sanity_image_url/src/model/sanity_palette.dart';

class SanityAsset extends SanityImageSource {
  const SanityAsset(
      {required String id, required this.url, this.lqip, this.palette})
      : super(id: id);

  final String? lqip;
  final String url;
  final SanityPalette? palette;

  static SanityAsset fromJson(json) {
    String? lqip;

    if (json['metadata']?['lqip'] != null) {
      lqip = json['metadata']['lqip'].toString();
      lqip = lqip.length > 23 ? lqip.substring(23) : lqip;
    }

    return SanityAsset(
      id: json['_id'],
      url: json['url'] ?? '',
      lqip: lqip,
      palette: json['metadata']?['palette'] != null
          ? SanityPalette.fromJson(json['metadata']?['palette'])
          : null,
    );
  }
}
