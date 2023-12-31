import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/injection.dart';
import 'package:chatgpt/states/chat_ui_state.dart';
import 'package:chatgpt/states/message_state.dart';
import 'package:chatgpt/states/session_state.dart';
import 'package:chatgpt/widgets/chat_gpt_model.dart';
import 'package:chatgpt/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'message_list.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSession = ref.watch(activeSessionProvider);

    return Container(
      color: const Color(0xFFF1F1F1), // 灰色
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GptModelWidget(
            active: activeSession?.model.toModel(),
            onModelChanged: (model) {
              ref.read(chatUiProvider.notifier).model = model;
            },
          ),
          const Expanded(
            // 聊天消息列表
            child: ChatMessageList(),
          ),

          // 输入框
          const ChatInputWidget(),
        ],
      ),
    );
  }
}
