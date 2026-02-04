import 'dart:math';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

const gradientColorPresets = [
  Color(0xFF017BC8), // Blue
  Color(0xFF00897B), // Teal
  Color(0xFF2E7D32), // Green
  Color(0xFF7B1FA2), // Purple
  Color(0xFFC62828), // Red
  Color(0xFFE65100), // Orange
  Color(0xFFAD1457), // Pink
  Color(0xFF283593), // Indigo
];

const defaultGradientColor = Color(0xFF017BC8);

final Map<String, Color> _gradientColorCache = {};

void clearGradientColorCache() => _gradientColorCache.clear();

int get gradientColorCacheSize => _gradientColorCache.length;

Color? getCachedGradientColor(String? url) {
  if (url == null || url.isEmpty) return null;
  return _gradientColorCache[url];
}

@visibleForTesting
void seedGradientColorCache(String url, Color color) =>
    _gradientColorCache[url] = color;

Color matchGradientColor(Color dominantColor) {
  var bestMatch = gradientColorPresets.first;
  var bestDistance = double.infinity;

  for (final preset in gradientColorPresets) {
    final dr = dominantColor.red - preset.red;
    final dg = dominantColor.green - preset.green;
    final db = dominantColor.blue - preset.blue;
    final distance = sqrt(dr * dr + dg * dg + db * db);

    if (distance < bestDistance) {
      bestDistance = distance;
      bestMatch = preset;
    }
  }

  return bestMatch;
}

Future<Color> extractGradientColor(String? thumbnailUrl) async {
  if (thumbnailUrl == null || thumbnailUrl.isEmpty) {
    return defaultGradientColor;
  }

  final cached = _gradientColorCache[thumbnailUrl];
  if (cached != null) {
    return cached;
  }

  try {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(thumbnailUrl),
      maximumColorCount: 4,
    );

    final dominantColor = paletteGenerator.dominantColor?.color;
    if (dominantColor == null) {
      return defaultGradientColor;
    }

    final result = matchGradientColor(dominantColor);
    _gradientColorCache[thumbnailUrl] = result;
    return result;
  } catch (_) {
    return defaultGradientColor;
  }
}
