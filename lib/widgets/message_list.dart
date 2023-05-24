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
    final messages = ref.watch(messageProvider);
    final listController = useScrollController();

    ref.listen(messageProvider, (previous, next) {
      Future.delayed(const Duration(milliseconds: 50), () {
        listController.jumpTo(
          listController.position.maxScrollExtent,
        );
      });
    });

    return ListView.separated(
      controller: listController,
      itemBuilder: (context, index) {
        return MessageItem(message: messages[index]);
      },
      itemCount: messages.length,
      separatorBuilder: (context, index) => const Divider(
        height: 16,
      ),
    );
  }
}
