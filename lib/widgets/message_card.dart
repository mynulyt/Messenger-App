import 'package:flutter/material.dart';
import 'package:messenger_app/api/apis.dart';
import 'package:messenger_app/main.dart';
import 'package:messenger_app/model/message.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return Apis.user.uid == widget.message.fromId
        ? _greenMessage()
        : _bluMessage();
  }

  //for sender msg
  Widget _bluMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Message
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .03, vertical: mq.height * .01),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              border: Border.all(color: Colors.lightBlue),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(mq.width * .04),
            child: Text(
              widget.message.msg,
              style: TextStyle(color: Colors.black87, fontSize: 15),
            ),
          ),
        ),
        //For sent time
        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(
            widget.message.sent,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        )
      ],
    );
  }

  //for user msg
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Message

        //For sent time
        Row(
          children: [
            SizedBox(
              width: mq.width * .03,
            ),
            Icon(
              Icons.done_all_rounded,
              size: 20,
              color: Colors.blue,
            ),
            SizedBox(
              width: mq.width * .02,
            ),
            Text(
              '${widget.message.read}12:00 AM',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .03, vertical: mq.height * .01),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.lightBlue),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(mq.width * .04),
            child: Text(
              widget.message.msg,
              style: TextStyle(color: Colors.black87, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
