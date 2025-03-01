import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:messenger_app/Helper/date_util.dart';
import 'package:messenger_app/model/user_chat.dart';

class ViewProfileScreen extends StatelessWidget {
  final ChatUser user;
  const ViewProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        title: Text(user.name),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Joined On ${MyDateUtil.getLastMessageTime(context: context, time: user.createdAt, showYear: true)}",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * .1),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.height * .2,
                  height: MediaQuery.of(context).size.height * .2,
                  fit: BoxFit.cover,
                  imageUrl: user.image,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Text(
                user.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              Text(
                user.email,
                style: const TextStyle(color: Colors.black54, fontSize: 16),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "About",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      user.about,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
            ],
          ),
        ),
      ),
    );
  }
}
