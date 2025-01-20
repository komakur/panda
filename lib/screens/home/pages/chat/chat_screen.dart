import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panda/blocs/auth/auth_bloc.dart';
import 'package:panda/models/message/message.dart';
import 'package:panda/models/user_profile/user_profile.dart';
import 'package:panda/screens/home/pages/chat/chat_bloc/chat_bloc.dart';
import 'package:panda/services/injectable.dart';

import 'widgets/widgets.dart';

@RoutePage()
class ChatsScreen extends StatefulWidget implements AutoRouteWrapper {
  const ChatsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final UserProfile(:username, :token) =
        context.read<AuthBloc>().state.userProfile;

    return BlocProvider(
      create: (context) => getIt<ChatBloc>()
        ..connectToChat(
          Message(
            sender: username,
            token: token,
            type: MessageType.register,
          ),
        ),
      child: this,
    );
  }

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProfile = context.read<AuthBloc>().state.userProfile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];

                      return Builder(builder: (context) {
                        return ChatMessageBubble(
                          message: message,
                          isMe: userProfile.username == message.sender,
                        );
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration:
                          const InputDecoration(labelText: "Type a message"),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final messageText = _messageController.text.trim();
                      if (messageText.isNotEmpty) {
                        context.read<ChatBloc>().sendMessage(
                              Message(text: messageText),
                            );
                        _messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
