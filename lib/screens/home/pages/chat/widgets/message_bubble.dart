import 'package:flutter/material.dart';
import 'package:panda/models/message/message.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatMessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ChatMessageBubble({
    required this.message,
    required this.isMe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMe ? Colors.blue[100] : Colors.grey[300];
    final textColor = isMe ? Colors.black : Colors.black87;

    final Message(
      text: messageText,
      :sender,
      :sentAt,
    ) = message;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 250),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              messageText,
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 4),
            if (sentAt != null)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  timeago.format(sentAt),
                  style: TextStyle(
                      fontSize: 10, color: textColor.withOpacity(0.6)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
