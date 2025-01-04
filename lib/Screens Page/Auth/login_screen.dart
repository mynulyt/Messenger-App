import 'package:flutter/material.dart';
import 'package:messenger_app/Screens%20Page/home_screen.dart';
import 'package:messenger_app/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
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
          AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5,
            width: mq.width * .5,
            duration: Duration(seconds: 1),
            child: Image.asset("images/icon.png"),
          ),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 122, 202, 124),
                    shape: StadiumBorder()),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                icon: Image.asset(
                  "images/google.png",
                  height: mq.height * .5,
                ),
                label: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(text: 'Sign In with '),
                        TextSpan(
                          text: 'Google',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                )),
          ),
        ],
      ),
    );
  }
}
