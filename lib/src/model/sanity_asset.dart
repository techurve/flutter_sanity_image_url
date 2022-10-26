import 'package:flutter_sanity_image_url/src/model/sanity_image.dart';
import 'package:flutter_sanity_image_url/src/model/sanity_palette.dart';

class SanityAsset extends SanityImageSource {
  const SanityAsset(
      {required String id, required this.url, required this.lqip, this.palette})
      : super(id: id);

  final String lqip;
  final String url;
  final SanityPalette? palette;

  static SanityAsset fromJson(json) {
    String lqip = json['metadata']['lqip'].toString();
    lqip = lqip.substring(23);
    return SanityAsset(
      id: json['_id'],
      url: json['url'] ?? '',
      lqip: lqip,
      palette: SanityPalette.fromJson(json['metadata']?['palette']),
    );
  }
}
