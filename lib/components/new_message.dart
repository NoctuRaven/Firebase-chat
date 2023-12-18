import 'package:chat_firebase/core/services/auth/auth_service.dart';
import 'package:chat_firebase/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = "";
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      final msg = await ChatService().save(_message, user);
      print(msg?.id);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              setState(() => _message = value);
            },
            controller: _messageController,
            decoration: InputDecoration(
              labelText: 'Enviar mensagem...',
            ),
            onSubmitted: (value) {
              if (_message.trim().isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ),
        IconButton(
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send))
      ],
    );
  }
}
