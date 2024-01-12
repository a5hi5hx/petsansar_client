// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/services.dart';
import 'package:petsansar_client/screens/home/profilepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './exports.dart';
int? isviewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  //  DatabaseHelper databaseHelper = DatabaseHelper();
  //   await databaseHelper.initDatabase();
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
         ChangeNotifierProvider(
        create: (_) => CartProvider(),
      ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);  

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   @override
void initState() {
    super.initState();
    initPlatform();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: OnBoard(),

   home: isviewed != 0 ? OnBoard() : LogoInitial(),
    );
  }

  void initPlatform() async {
    String notificationId = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await OneSignal.shared.setAppId('*********ad appid****');
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      OSNotificationDisplayType.notification;
    });
    
    // OneSignal.shared
    //     .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
    //   String? onesignalUserId = changes.to.userId;
    //   print('Player ID: ' + onesignalUserId!);
    // });
    await OneSignal.shared.getDeviceState().then((value) => {
          notificationId = value!.userId!,
        });
    prefs.setString('playerId', notificationId);
  }
}
