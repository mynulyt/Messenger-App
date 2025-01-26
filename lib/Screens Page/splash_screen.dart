import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger_app/Screens%20Page/Auth/login_screen.dart';
import 'package:messenger_app/Screens%20Page/home_screen.dart';
import 'package:messenger_app/api/apis.dart';
import 'package:messenger_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.white),
      );

      if (Apis.auth.currentUser != null) {
        debugPrint('User: ${Apis.auth.currentUser}');
        debugPrint('UserAdditionalInfo: ${Apis.auth.currentUser}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Welcome Chat of Duty"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset("images/icon.png"),
          ),
          Positioned(
              bottom: mq.height * .10,
              width: mq.width,
              child: Center(
                  child: Text(
                "Developed By Mynul Alam",
                style: TextStyle(color: Colors.black),
              ))),
        ],
      ),
    );
  }
}
