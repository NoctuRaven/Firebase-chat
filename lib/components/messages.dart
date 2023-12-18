import 'package:chat_firebase/components/message_bobble.dart';
import 'package:chat_firebase/core/models/chat_message.dart';
import 'package:chat_firebase/core/services/auth/auth_mock_service.dart';
import 'package:chat_firebase/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../core/services/auth/auth_firebase_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthFirebaseService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text("Sem dados. Vamos conversar ?"),
          );
        } else {
          final msg = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msg.length,
            itemBuilder: (context, index) {
              return MessageBobble(
                key: ValueKey(msg[index].id),
                message: msg[index],
                belongsToCurrentUser: currentUser?.id == msg[index].userId,
              );
            },
          );
        }
      },
    );
  }
}
