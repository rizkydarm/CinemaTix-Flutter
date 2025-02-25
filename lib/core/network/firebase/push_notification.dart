
part of '../../_core.dart';

class PushNotification {

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
  
  static void initialize() {
    if (Platform.isAndroid) {
    
    final firebaseMessaging = FirebaseMessaging.instance;

    firebaseMessaging.requestPermission().then((setting) {
      firebaseMessaging.getToken().then((token) {
        getit.get<Talker>().info("Firebase Messaging Token: $token");
        
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          
          if (message.notification != null) {
            getit.get<Talker>().info('Message also contained a notification: ${message.notification?.title ?? ""} ${message.notification?.body ?? ""}');
          }
        });

        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          
        });
      });
    });
  }
  }
}