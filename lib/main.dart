import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger_app/Screens%20Page/splash_screen.dart';
import 'package:messenger_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

//For Media Query
late Size mq;

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Chat of Duty",
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
          backgroundColor: Colors.white,
        )),
        home: SplashScreen());
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
