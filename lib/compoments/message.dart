import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({super.key, required this.message, required this.sender, required this.isMe});

  final String message;
  final String sender;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        crossAxisAlignment: isMe ?CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender),
          Container(
            // height: 50,
            decoration: BoxDecoration(
                color: isMe? Colors.pinkAccent: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: isMe? Radius.circular(0): Radius.circular(20),
                    bottomLeft: isMe? Radius.circular(20) : Radius.circular(0),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                message,
                style: TextStyle(color: isMe?Colors.white: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
