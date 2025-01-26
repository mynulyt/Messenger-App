import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_app/Helper/Dialouge.dart';
import 'package:messenger_app/Screens%20Page/home_screen.dart';
import 'package:messenger_app/api/apis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  void _handleGoogleButtonClick() async {
    // Show loading indicator
    Dialouge.showProgressBar(context);

    // Attempt to sign in with Google
    final user = await _signInWithGoogle();
    Navigator.pop(context); // Remove the progress bar

    if (user != null) {
      // Log user info (ensure this doesn't cause crashes)
      debugPrint('User: ${user.user}');
      debugPrint('UserAdditionalInfo: ${user.additionalUserInfo}');

      if ((await Apis.userExits())) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        await Apis.createUser().then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        });
      }

      // Navigate to HomeScreen
    }
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      // Check internet connection
      await InternetAddress.lookup('google.com');

      // Trigger the Google sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        Dialouge.showSnackbar(context, "Sign-in canceled!");
        return null;
      }

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential for Firebase authentication
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      return await Apis.auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Error during Google sign-in: $e');
      Dialouge.showSnackbar(context, "Something went wrong! Check Internet.");
      return null;
    }
  }
  // _signOut()async{
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn().signInSilently();
  // }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome Chat of Duty"),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5,
            width: mq.width * .5,
            duration: const Duration(seconds: 1),
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
                shape: const StadiumBorder(),
              ),
              onPressed: _handleGoogleButtonClick,
              icon: Image.asset(
                "images/google.png",
                height: mq.height * .03,
              ),
              label: RichText(
                text: const TextSpan(
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
