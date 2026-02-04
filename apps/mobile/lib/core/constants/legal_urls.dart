import 'package:url_launcher/url_launcher.dart';

abstract final class LegalUrls {
  static const termsOfService =
      'https://igsr5.notion.site/Shelfie-2f4626d4a51f80a397cad100856f95be';

  static const privacyPolicy =
      'https://igsr5.notion.site/Shelfie-2f4626d4a51f8047a33aed8f9ca524b7';

  static const inquiryForm = 'https://forms.gle/DYTJGoGApyhHTr6G7';

  static Future<bool> openTermsOfService() async {
    return launchUrl(
      Uri.parse(termsOfService),
      mode: LaunchMode.inAppBrowserView,
    );
  }

  static Future<bool> openPrivacyPolicy() async {
    return launchUrl(
      Uri.parse(privacyPolicy),
      mode: LaunchMode.inAppBrowserView,
    );
  }

  static Future<bool> openInquiryForm() async {
    return launchUrl(
      Uri.parse(inquiryForm),
      mode: LaunchMode.externalApplication,
    );
  }
}
