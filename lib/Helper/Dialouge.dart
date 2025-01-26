import 'package:flutter/material.dart';

class Dialouge {
  // Function to show a snackbar with a message
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3), // Auto-dismiss after 3 seconds
      ),
    );
  }

  // Function to show a dismissible progress dialog
  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Function to hide the progress dialog
  static void hideProgressBar(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(); // Dismiss the dialog
  }
}
