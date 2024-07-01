import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import 'app_setup.dart';
import 'configuration/constants.dart';
import 'configuration/theme.dart';
import 'configuration/token_manager.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await AppSetup.init();
  final Widget firstScreen = AppSetup.start();

  runApp(MyApp(homeScreen: firstScreen));
}

class MyApp extends StatefulWidget {

  final Widget homeScreen;
  const MyApp({super.key, required this.homeScreen});

  @override
  State<MyApp> createState() => _MyAppState();

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return FlutterSizer(
  //     builder: (context, orientation, screenType) {
  //       return MaterialApp(
  //         title: 'Flutter Demo',
  //         theme: ThemeData(
  //           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //           useMaterial3: true,
  //           fontFamily: 'Poppins',
  //         ),
  //         home: homeScreen,
  //       );
  //     },
  //   );
  // }
}


class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  late Widget _homeScreen;

  Timer? _timer;

  @override
  void initState() {
    //Init properties
    _homeScreen = widget.homeScreen;
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _startTimer();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

  }

  void _startTimer(){
    print("_startTimer");

    _timer = Timer.periodic(const Duration(
        seconds: Constants.timerDelay
    ), (timer){
      print("Timer.periodic => ${DateTime.now()}");
      if(TokenManager.isExpired()){
        AppSetup.localStorageService.clear()
            .whenComplete((){
          setState(() {

          });
        });

      }else{
        //Automatic refresh
        TokenManager.refresh();
      }

    });

    if(mounted){
      setState(() {

      });
    }
  }


  _stopTimer(){
    print("_stopTimeer");
    if(_timer != null){
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //Implement didChangeAppLifecycleState

    if(state == AppLifecycleState.paused){
      print("AppLifecycleState.paused");
      _stopTimer();
    }

    if(state == AppLifecycleState.resumed){

      _startTimer();

      print("AppLifecycleState.resumed");
      //Check token expiration
      if(TokenManager.isExpired()){
        AppSetup.localStorageService.clear()
            .whenComplete((){
          if(mounted){
            setState(() {

            });
          }
        });

      }

    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    //Implement dispose
    _stopTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (contxt, orientation, screenType){
        return Listener(
          onPointerDown: (event){
            print("$event");
            if(TokenManager.isExpired()){
              if(mounted){
                setState(() {
                });
              }
            }else{
              TokenManager.refresh();
            }
          },
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme.light(),
            //home: MainScreen(title: "BB Social",)
            home: TokenManager.isExpired() ?
            AppSetup.start() :
            _homeScreen,
            //home: const RegisterScreen(),
          ),
        );
      },
    );
  }
}
