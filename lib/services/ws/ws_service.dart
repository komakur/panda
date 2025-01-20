import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:panda/app/config.dart';
import 'package:panda/models/message/message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket service. It uses node.js server.
@Singleton(scope: 'auth')
class WebSocketService {
  final String wsBaseUrl = AppConfig.appWsClientUrl;
  WebSocketChannel? _channel;
  String? _username;

  bool get isConnected => _channel != null && _channel!.closeCode == null;

  /// Connect to the WebSocket server and register the user
  void connect(String username, String token) {
    if (isConnected) {
      return;
    }
    _username = username;
    _channel = WebSocketChannel.connect(Uri.parse(wsBaseUrl));

    // Register with the server
    final registrationMessage = Message(
      type: MessageType.register,
      sender: username,
      token: token,
    );

    _channel?.sink.add(jsonEncode(registrationMessage.toJson()));
  }

  /// Send a chat message
  void sendMessage(String message) {
    if (_username == null) {
      throw Exception("You must register before sending messages!");
    }

    final chatMessage = Message(text: message).toJson();

    _channel?.sink.add(jsonEncode(chatMessage));
  }

  /// Getter for the stream of chat messages
  Stream<Message> get chatMessagesStream {
    return _channel!.stream.map((data) {
      return Message.fromJson(jsonDecode(data));
    }).where((data) => data.type.isMessage);
  }

  /// Close the WebSocket connection
  void disconnect() {
    _channel?.sink.close();
  }
}
