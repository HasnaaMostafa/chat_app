import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String sender;
  final String lastMessage;
  final VoidCallback onTap;

  const ChatItem({
    Key? key,
    required this.sender,
    required this.lastMessage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
          child: Text(sender[0]),
        ),
        title: Text(
          sender,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
