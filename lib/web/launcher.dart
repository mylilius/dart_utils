library dart_utils;

import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {

  static Future<void> launchUrl(String _url) async {
    try {
      if (await canLaunch(_url)) {
        await launch(_url);
      } else {
        throw Exception('Error Launching URL');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

}