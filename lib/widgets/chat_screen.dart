import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/injection.dart';
import 'package:chatgpt/states/chat_ui_state.dart';
import 'package:chatgpt/states/message_state.dart';
import 'package:chatgpt/widgets/user_input.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'message_list.dart';

class ChatScreen extends HookConsumerWidget {
  ChatScreen({super.key});

  final List<Message> messages = [
    Message(
        id: uuid.v4(),
        content: "Hello ya",
        isUser: true,
        timestamp: DateTime.now()),
    Message(
        id: uuid.v4(),
        content: "How are you?",
        isUser: false,
        timestamp: DateTime.now()),
    Message(
        id: uuid.v4(),
        content: "Fine,Thank you. And you?",
        isUser: true,
        timestamp: DateTime.now()),
    Message(
        id: uuid.v4(),
        content: "I am fine.",
        isUser: false,
        timestamp: DateTime.now()),
  ];

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Expanded(
              // 聊天消息列表
              child: ChatMessageList(),
            ),

            // 输入框
            UserInputWidget(),
          ],
        ),
      ),
    );
  }
}
