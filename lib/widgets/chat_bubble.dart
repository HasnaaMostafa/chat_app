
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color:  Color(0xffE65100),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32),
              )
          ),
          padding: const EdgeInsets.all(18),
          child: Text(message.message,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white))),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              )
          ),
          padding: const EdgeInsets.all(18),
          child: Text(message.message,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white))),
    );
  }
}