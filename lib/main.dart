import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:totem_ai/messages_screen.dart';
import 'package:totem_ai/sons_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'transition_route_observer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  runApp(const MyApp());
}

ThemeData theme = ThemeData(
  primaryColor: Colors.green,
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: Colors.lightGreen),
  // fontFamily: 'SourceSansPro',
  textTheme: TextTheme(
    headline3: const TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 45.0,
      // fontWeight: FontWeight.w400,
      color: Colors.green,
    ),
    button: const TextStyle(
      // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
      fontFamily: 'OpenSans',
    ),
    caption: TextStyle(
      fontFamily: 'NotoSans',
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.green[300],
    ),
    headline1: const TextStyle(fontFamily: 'Quicksand'),
    headline2: const TextStyle(fontFamily: 'Quicksand'),
    headline4: const TextStyle(fontFamily: 'Quicksand'),
    headline5: const TextStyle(fontFamily: 'NotoSans'),
    headline6: const TextStyle(fontFamily: 'NotoSans'),
    subtitle1: const TextStyle(fontFamily: 'NotoSans'),
    bodyText1: const TextStyle(fontFamily: 'NotoSans'),
    bodyText2: const TextStyle(fontFamily: 'NotoSans'),
    subtitle2: const TextStyle(fontFamily: 'NotoSans'),
    overline: const TextStyle(fontFamily: 'NotoSans'),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown)
      .copyWith(secondary: Colors.green),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications()
        .actionStream
        .listen((ReceivedNotification receivedNotification) {
      Navigator.of(context).pushNamed('/NotificationPage', arguments: {
        // your page params. I recommend you to pass the
        // entire *receivedNotification* object
        //id: receivedNotification.id
      });
    });
    return MaterialApp(
      title: 'Login TotemAI',
      debugShowCheckedModeBanner: false,
      darkTheme: theme,
      theme: theme,
      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        DashboardScreen.routeName: (context) => const DashboardScreen(),
        SonsScreen.routeName: (context) => const SonsScreen(),
        MessagesScreen.routeName: (context) => const MessagesScreen(),
      },
    );
  }
}
