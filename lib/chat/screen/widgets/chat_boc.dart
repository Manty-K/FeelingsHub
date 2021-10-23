import 'package:flutter/material.dart';
import 'package:hacklegendsa/chat/model/message_owner.enum.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({required this.text, required this.messageOwner});

  final String text;
  final MessageOwner messageOwner;

  @override
  Widget build(BuildContext context) {
    const chatBubbleRadius = 20.0;
    return Row(
      children: [
        if (messageOwner == MessageOwner.sender) Spacer(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: messageOwner == MessageOwner.sender
                ? const BorderRadius.only(
                    topRight: Radius.zero,
                    topLeft: Radius.circular(chatBubbleRadius),
                    bottomRight: Radius.circular(chatBubbleRadius),
                    bottomLeft: Radius.circular(chatBubbleRadius),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(chatBubbleRadius),
                    topLeft: Radius.zero,
                    bottomRight: Radius.circular(chatBubbleRadius),
                    bottomLeft: Radius.circular(chatBubbleRadius),
                  ),
            border: Border.all(
              width: 1,
              color: messageOwner == MessageOwner.sender
                  ? Colors.blue
                  : Colors.green,
            ),
          ),
          child: Text(
            text,
            softWrap: true,
            style: TextStyle(fontSize: 15),
          ),
        ),
        if (messageOwner == MessageOwner.receiver) Spacer(),
      ],
    );
  }
}
