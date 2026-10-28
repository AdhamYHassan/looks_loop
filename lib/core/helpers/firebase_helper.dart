import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:looks_loop/core/helpers/shared_prefs_helper.dart';

class FireBaseApi {
  final _fireBaseMessaging = FirebaseMessaging.instance;
  static bool appInitialized = false;

  Future<void> initNotifications() async {
    await _fireBaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    try {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final apnsToken = await _fireBaseMessaging.getAPNSToken();
        debugPrint("APNs Token: $apnsToken");
      }

      // ignore: deprecated_member_use
      final fcmToken = await _fireBaseMessaging.getToken();
      debugPrint("FCM Token: $fcmToken");

      if (fcmToken != null) {
        await SharedPrefsHelper.setFcmToken(fcmToken);
      }
    } catch (e) {
      debugPrint("Error fetching FCM token: $e");
    }
  }

  static void markAppAsInitialized() {
    appInitialized = true;
    debugPrint("App marked as fully initialized");
  }
}
