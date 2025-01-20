import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:panda/models/message/message.dart';
import 'package:panda/services/ws/ws_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

/// ChatBloc uses WebSocketService. Listens to Stream of coming messages.
@singleton
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebSocketService _webSocketService;
  StreamSubscription<Message>? _messageSubscription;

  ChatBloc(this._webSocketService) : super(const ChatState()) {
    on<_ConnectedToChat>(_onConnectToChat);
    on<_SentMessage>(_onSendMessage);
    on<_MessageReceived>(_onNewMessageReceived);
  }

  void connectToChat(Message message) =>
      add(_ConnectedToChat(message: message));

  void sendMessage(Message message) => add(_SentMessage(message: message));

  void _onConnectToChat(_ConnectedToChat event, Emitter<ChatState> emit) {
    final Message(:sender, :token) = event.message;

    _webSocketService.connect(sender, token);

    // Subscribe to chat messages
    _messageSubscription = _webSocketService.chatMessagesStream.listen(
      (message) {
        add(_MessageReceived(message: message));
      },
    );
  }

  void _onSendMessage(_SentMessage event, Emitter<ChatState> emit) {
    _webSocketService.sendMessage(event.message.text);
  }

  void _onNewMessageReceived(_MessageReceived event, Emitter<ChatState> emit) {
    final updatedMessages = List<Message>.from(state.messages)
      ..add(event.message);

    emit(state.copyWith(messages: updatedMessages));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _webSocketService.disconnect();

    return super.close();
  }
}
