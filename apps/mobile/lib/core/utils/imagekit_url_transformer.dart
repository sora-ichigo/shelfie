class ImageKitUrlTransformer {
  static const String _imageKitDomain = 'ik.imagekit.io';
  static const int _defaultSize = 256;

  static String? transformUrl(String? url, {int? size}) {
    if (url == null) return null;
    if (url.isEmpty) return '';
    if (!isImageKitUrl(url)) return url;

    final targetSize = size ?? _defaultSize;
    final transformations = 'tr=w-$targetSize,h-$targetSize,q-100,f-auto';

    final uri = Uri.parse(url);

    return Uri(
      scheme: uri.scheme,
      host: uri.host,
      path: uri.path,
      query: transformations,
    ).toString();
  }

  static bool isImageKitUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.host.contains(_imageKitDomain);
    } catch (_) {
      return false;
    }
  }
}
