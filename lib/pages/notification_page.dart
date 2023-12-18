import 'package:chat_firebase/core/services/notifications/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<ChatNotificationService>();
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas notificações'),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].body),
            onTap: () => service.remove(index),
          );
        },
      ),
    );
  }
}
