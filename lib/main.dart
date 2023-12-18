import 'package:chat_firebase/core/services/notifications/chat_notification_service.dart';
import 'package:chat_firebase/pages/auth_or_app_page.dart';
import 'package:chat_firebase/pages/auth_page.dart';
import 'package:chat_firebase/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatNotificationService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthOrAppPage(),
      ),
    );
  }
}
