import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/injection.dart';
import 'package:chatgpt/states/chat_ui_state.dart';
import 'package:chatgpt/states/message_state.dart';
import 'package:chatgpt/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'message_list.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push('/history');
            },
            icon: const Icon(Icons.history),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
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
