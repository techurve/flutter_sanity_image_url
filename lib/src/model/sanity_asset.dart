import 'package:flutter_sanity_image_url/src/model/sanity_palette.dart';

class SanityAsset {
  const SanityAsset({required this.url, required this.lqip, this.palette});

  final String lqip;
  final String url;
  final SanityPalette? palette;

  static SanityAsset fromJson(json) {
    String lqip = json['metadata']['lqip'].toString();
    lqip = lqip.substring(23);
    return SanityAsset(
      url: json['url'] ?? '',
      lqip: lqip,
      palette: SanityPalette.fromJson(json['metadata']?['palette']),
    );
  }

  @override
  List<Object?> get props => [lqip, url];
}
