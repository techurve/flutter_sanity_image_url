import 'dart:ui';

/// A model for Sanity Color of an image. contains background, foreground and recommended title colors.
class SanityColor {
  SanityColor(this.background, this.foreground, this.title);

  Color background;
  Color foreground;
  Color title;

  /// parses [json] into a [SanityColor].
  factory SanityColor.fromJson(json) {
    return SanityColor(
      HexColor.fromHex(json['background']),
      HexColor.fromHex(json['foreground']),
      HexColor.fromHex(json['title']),
    );
  }

  /// returns a [String] representation of the [SanityColor] object.
  @override
  String toString() {
    return "background: ${background.toHex()}, foreground: ${foreground.toHex()}, title: ${title.toHex()}";
  }
}

/// An extension providing hexadecimal string conversions on [Color].
extension HexColor on Color {
  /// Parses a hexadecimal color [String] into a [Color] object.
  /// String is in the format:
  /// - "aabbcc"
  /// - "ffaabbcc"
  /// - "abc"
  /// with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
    } else if (hexString.length == 3 || hexString.length == 4) {
      buffer.write('ff');
      String rgb = hexString.replaceFirst("#", '');
      buffer.write(rgb[0] * 2);
      buffer.write(rgb[1] * 2);
      buffer.write(rgb[2] * 2);
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Returns a hexadecimal [String] representation of this [Color].
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
