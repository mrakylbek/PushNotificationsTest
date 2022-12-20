// // ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     init();
//     super.initState();
//   }

//   init() async {
//     String deviceToken = await getDeviceToken();
//     print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFCIATION ######");
//     print(deviceToken);
//     print("############################################################");

//     // listen for user to click on notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
//       String? title = remoteMessage.notification!.title;
//       String? description = remoteMessage.notification!.body;

//       //im gonna have an alertdialog when clicking from push notification
//       Alert(
//         context: context,
//         type: AlertType.error,
//         title: title, // title from push notification data
//         desc: description, // description from push notifcation data
//         buttons: [
//           DialogButton(
//             child: Text(
//               "COOL",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//             onPressed: () => Navigator.pop(context),
//             width: 120,
//           )
//         ],
//       ).show();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Center(
//                     child: Text(
//                   "Firebase Messaging",
//                   style: TextStyle(fontSize: 40),
//                 )),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                     child: Text(
//                   "How to integrate Firebase Messaging",
//                   style: TextStyle(fontSize: 18),
//                 ))
//               ],
//             ),
//           )
//         ],
//       ),
//     ));
//   }

// ignore_for_file: prefer_const_constructors

//   //get device token to use for push notification
//   Future getDeviceToken() async {
//     //request user permission for push notification
//     FirebaseMessaging.instance.requestPermission();
//     FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
//     String? deviceToken = await _firebaseMessage.getToken();
//     return (deviceToken == null) ? "" : deviceToken;
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  late final FirebaseMessaging _messaging;
  late int _totalNotifications;

  PushNotification? _notificationInfo;

  @override
  void initState() {
    _totalNotifications = 0;

    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('GET GET GET GET GET GET GET GET GET GET ');
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      print(notification.toString());
      print(notification.title);
      print(notification.body);
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });
    registerNotification();

    // Call here
    checkForInitialMessage();
    super.initState();
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    print(await _messaging.getToken());
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    // Add the following line
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // var _notificationInfo;
        // Parse the message received
        // PushNotification notification = PushNotification(
        //   title: message.notification?.title,
        //   body: message.notification?.body,
        // );

        // setState(() {
        //   _notificationInfo = notification;
        //   _totalNotifications++;
        // });
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
        brightness: Brightness.dark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'App for capturing Firebase Push Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16.0),
          NotificationBadge(totalNotifications: _totalNotifications),
          SizedBox(height: 16.0),
          // TODO: add the notification text here
          _notificationInfo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'TITLE: ${_notificationInfo!.title}',

                      'TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      // 'BODY: ${_notificationInfo!.body}',

                      'BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}
