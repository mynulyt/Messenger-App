import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/Screens%20Page/chat_screen.dart';
import 'package:messenger_app/main.dart';
import 'package:messenger_app/model/user_chat.dart';

class UserChatCart extends StatefulWidget {
  final ChatUser user;
  final ChatUser? userss;
  const UserChatCart({
    super.key,
    required this.user,
    this.userss,
  });

  @override
  State<UserChatCart> createState() => _UserChatCartState();
}

class _UserChatCartState extends State<UserChatCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blue.shade100,
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          //for chat screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChatScreen(
                        user: widget.user,
                      )));
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(mq.height * .3),
            child: CachedNetworkImage(
              width: mq.height * .055,
              height: mq.height * .055,
              imageUrl: widget.user.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person)),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(
            widget.user.about,
            maxLines: 1,
          ),
          trailing: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade400,
                borderRadius: BorderRadius.circular(10)),
          ),
          //  trailing: Text(
          //   "12:00 PM",
          //   style: TextStyle(color: Colors.black54),
          // ),
        ),
      ),
    );
  }
}
