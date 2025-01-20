import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    @Default('') String sender,
    @Default('') String text,
    DateTime? sentAt,
    @Default('') String token,
    @Default(MessageType.message) MessageType type,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

enum MessageType {
  register,
  message;

  bool get isRegister => this == register;
  bool get isMessage => this == message;
}
