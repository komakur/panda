part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.connectedToChat({
    @Default(Message()) Message message,
  }) = _ConnectedToChat;

  const factory ChatEvent.sentMessage({
    @Default(Message()) Message message,
  }) = _SentMessage;

  const factory ChatEvent.messageReceived({
    @Default(Message()) Message message,
  }) = _MessageReceived;
}
