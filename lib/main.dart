// // import 'dart:convert';

// // import 'package:fcm_notification_test/empty_page.dart';
// // import 'package:fcm_notification_test/home_page.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';

// // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   FirebaseMessaging.instance.getToken().then((value) {
// //     print('getToken: $value');
// //   });

// //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
// //     print('onMessageOpenedApp: $message');
// //     Navigator.pushNamed(navigatorKey.currentState!.context, '/push-page',
// //         arguments: {'message', jsonEncode(message.data)});
// //   });

// //   FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
// //     if (message != null) {
// //       Navigator.pushNamed(navigatorKey.currentState!.context, '/push-page',
// //           arguments: {'message', jsonEncode(message.data)});
// //     }
// //   });

// //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// //   runApp(const MyApp());
// // }

// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   print('_firebaseMessagingBackgroundHandler: $message');
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       // home: EmptyPage(),
// //       navigatorKey: navigatorKey,
// //       routes: {
// //         '/': (context) => EmptyPage(),
// //         '/push-page': (context) => const HomePage(),
// //       },
// //     );
// //   }
// // }

// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   Future<void> _firebaseMessagingBackgroundHandler(
// //       RemoteMessage message) async {
// //     // If you're going to use other Firebase services in the background, such as Firestore,
// //     // make sure you call `initializeApp` before using other Firebase services.

// //     await Firebase.initializeApp(
// //         options: FirebaseOptions(
// //       appId: 'Add APP_IS',
// //       apiKey: 'ADD API_KEY',
// //       projectId: 'ADD_PROJECT_ID',
// //       messagingSenderId: '',
// //     ));
// //   }

// //   /// Create a [AndroidNotificationChannel] for heads up notifications
// //   late AndroidNotificationChannel channel;

// //   /// Initialize the [FlutterLocalNotificationsPlugin] package.
// //   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
// //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// //   if (!kIsWeb) {
// //     channel = const AndroidNotificationChannel(
// //       'tutorialspoint_notification', // id
// //       'Tutorialspoint Online', // title

// //       importance: Importance.high,
// //     );

// //     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// //     /// Create an Android Notification Channel.
// //     ///
// //     /// We use this channel in the `AndroidManifest.xml` file to override the
// //     /// default FCM channel to enable heads up notifications.
// //     await flutterLocalNotificationsPlugin
// //         .resolvePlatformSpecificImplementation<
// //             AndroidFlutterLocalNotificationsPlugin>()
// //         ?.createNotificationChannel(channel);

// //     /// Update the iOS foreground notification presentation options to allow
// //     /// heads up notifications.
// //     await FirebaseMessaging.instance
// //         .setForegroundNotificationPresentationOptions(
// //       alert: true,
// //       badge: true,
// //       sound: true,
// //     );
// //     print(await FirebaseMessaging.instance.getToken());
// //   }
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       RemoteNotification? notification = message.notification;
// //       AndroidNotification? android = message.notification?.android;
// //       if (notification != null && android != null && !kIsWeb) {
// //         FlutterLocalNotificationsPlugin().show(
// //           notification.hashCode,
// //           notification.title,
// //           notification.body,
// //           NotificationDetails(
// //             android: AndroidNotificationDetails(
// //               "tutorialspoint_notification",
// //               "Tutorialspoint Online",
// //               channelDescription: "",
// //               // TODO add a proper drawable resource to android, for now using
// //               //      one that already exists in example app.
// //               icon: 'notification',
// //             ),
// //           ),
// //         );
// //       }
// //     });
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // Try running your application with "flutter run". You'll see the
// //         // application has a blue toolbar. Then, without quitting the app, try
// //         // changing the primarySwatch below to Colors.green and then invoke
// //         // "hot reload" (press "r" in the console where you ran "flutter run",
// //         // or simply save your changes to "hot reload" in a Flutter IDE).
// //         // Notice that the counter didn't reset back to zero; the application
// //         // is not restarted.
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key, required this.title}) : super(key: key);

// //   // This widget is the home page of your application. It is stateful, meaning
// //   // that it has a State object (defined below) that contains fields that affect
// //   // how it looks.

// //   // This class is the configuration for the state. It holds the values (in this
// //   // case the title) provided by the parent (in this case the App widget) and
// //   // used by the build method of the State. Fields in a Widget subclass are
// //   // always marked "final".

// //   final String title;

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   int _counter = 0;

// //   void _incrementCounter() {
// //     setState(() {
// //       // This call to setState tells the Flutter framework that something has
// //       // changed in this State, which causes it to rerun the build method below
// //       // so that the display can reflect the updated values. If we changed
// //       // _counter without calling setState(), then the build method would not be
// //       // called again, and so nothing would appear to happen.
// //       _counter++;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // This method is rerun every time setState is called, for instance as done
// //     // by the _incrementCounter method above.
// //     //
// //     // The Flutter framework has been optimized to make rerunning build methods
// //     // fast, so that you can just rebuild anything that needs updating rather
// //     // than having to individually change instances of widgets.
// //     return Scaffold(
// //       appBar: AppBar(
// //         // Here we take the value from the MyHomePage object that was created by
// //         // the App.build method, and use it to set our appbar title.
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         // Center is a layout widget. It takes a single child and positions it
// //         // in the middle of the parent.
// //         child: Column(
// //           // Column is also a layout widget. It takes a list of children and
// //           // arranges them vertically. By default, it sizes itself to fit its
// //           // children horizontally, and tries to be as tall as its parent.
// //           //
// //           // Invoke "debug painting" (press "p" in the console, choose the
// //           // "Toggle Debug Paint" action from the Flutter Inspector in Android
// //           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
// //           // to see the wireframe for each widget.
// //           //
// //           // Column has various properties to control how it sizes itself and
// //           // how it positions its children. Here we use mainAxisAlignment to
// //           // center the children vertically; the main axis here is the vertical
// //           // axis because Columns are vertical (the cross axis would be
// //           // horizontal).
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             const Text(
// //               'You have pushed the button this many times:',
// //             ),
// //             Text(
// //               '$_counter',
// //               style: Theme.of(context).textTheme.headline4,
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _incrementCounter,
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ), // This trailing comma makes auto-formatting nicer for build methods.
// //     );
// //   }
// // }

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'home_page.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //initialize firebase from firebase core plugin
//   await Firebase.initializeApp();
//   runApp(MyApp(homeScreen: HomePage()));
// }

// class MyApp extends StatefulWidget {
//   final Widget? homeScreen;
//   MyApp({this.homeScreen});
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: this.widget.homeScreen,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Notify',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
