import 'package:doctor_book/common/app_theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../../../../common/app_theme/app_colors.dart';

class ChatInsideScreen extends StatefulWidget {
  const ChatInsideScreen({super.key});

  @override
  State<ChatInsideScreen> createState() => _ChatInsideScreenState();
}

class _ChatInsideScreenState extends State<ChatInsideScreen> {
  final List<types.Message> _messages = [];

  void _handleSendPressed(types.PartialText message) {
    final newMessage = types.TextMessage(
      author: types.User(id: 'user1'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: message.text,
    );

    setState(() {
      _messages.add(newMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        centerTitle: true,
        title: Text(
          'Trò chuyện với bác sĩ',
          style: AppStyles.whiteText,
        ),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: const types.User(id: 'user1'),
        theme: DefaultChatTheme(inputBackgroundColor: AppColors.grey500Color),
      ),
    );
  }
}
