import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/Screens%20Page/view_user_profile_screen.dart';
import 'package:messenger_app/main.dart';
import 'package:messenger_app/model/user_chat.dart';

class ProfileDialouge extends StatelessWidget {
  const ProfileDialouge({super.key, required this.user});
  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    double imageSize =
        mq.height * 0.2; // Define a fixed size for the circular image

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .35,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                user.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ClipOval(
                // Using ClipOval for a perfect circle
                child: CachedNetworkImage(
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  imageUrl: user.image,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: imageSize / 2,
                    child: const Icon(Icons.person, size: 50),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.info_outline,
                    color: Colors.blue, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewProfileScreen(user: user),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
