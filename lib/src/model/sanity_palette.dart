import 'package:flutter_sanity_image_url/src/model/sanity_color.dart';

/// A collection of [SanityColor] which are provided for images by sanity.
class SanityPalette {
  SanityPalette(
    this.darkMuted,
    this.darkVibrant,
    this.dominant,
    this.lightMuted,
    this.lightVibrant,
    this.muted,
    this.vibrant,
  );

  SanityColor darkMuted;
  SanityColor darkVibrant;
  SanityColor dominant;
  SanityColor lightMuted;
  SanityColor lightVibrant;
  SanityColor muted;
  SanityColor vibrant;

  /// Parses a json color palette. From the passed [json].
  factory SanityPalette.fromJson(json) {
    return SanityPalette(
      SanityColor.fromJson(json['darkMuted']),
      SanityColor.fromJson(json['darkVibrant']),
      SanityColor.fromJson(json['dominant']),
      SanityColor.fromJson(json['lightMuted']),
      SanityColor.fromJson(json['lightVibrant']),
      SanityColor.fromJson(json['muted']),
      SanityColor.fromJson(json['vibrant']),
    );
  }
}
