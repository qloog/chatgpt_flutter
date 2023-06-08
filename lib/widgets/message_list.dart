import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chatgpt/states/message_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'message_item.dart';

class ChatMessageList extends HookConsumerWidget {
  const ChatMessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(activeSessionMessagesProvider);
    final listController = useScrollController();

    ref.listen(activeSessionMessagesProvider, (previous, next) {
      Future.delayed(const Duration(milliseconds: 50), () {
        listController.jumpTo(
          listController.position.maxScrollExtent,
        );
      });
    });

    return ListView.separated(
      controller: listController,
      itemBuilder: (context, index) {
        final msg = messages[index];
        return msg.isUser
            ? SentMessageItem(
                message: msg,
                backgroundColor: const Color(0xFF8FE869), // 微信绿色气泡
              )
            : ReceivedMessageItem(message: msg);
      },
      itemCount: messages.length,
      separatorBuilder: (context, index) => const Divider(
        height: 16,
        color: Colors.transparent,
      ),
    );
  }
}
