import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  UrlLauncherHelper._();

  static Future<bool> openWhatsApp(String mobile) async {
    final cleanNumber = mobile.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanNumber.isEmpty) return false;

    final appUri = Uri.parse('whatsapp://send?phone=$cleanNumber');
    final webUri = Uri.parse('https://wa.me/$cleanNumber');

    if (await canLaunchUrl(appUri)) {
      return await launchUrl(appUri);
    } else if (await canLaunchUrl(webUri)) {
      return await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }

    return false;
  }
}

