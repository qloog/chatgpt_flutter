import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:chatgpt/states/chat_ui_state.dart';

import 'package:chatgpt/injection.dart';
import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/states/message_state.dart';

class UserInputWidget extends HookConsumerWidget {
  const UserInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUIState = ref.watch(chatUiProvider);
    final controller = useTextEditingController();

    return TextField(
      enabled: !chatUIState.requestLoading,
      controller: controller,
      decoration: InputDecoration(
        hintText: "Type a message",
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.send,
          ),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              _sendMessage(ref, controller);
            }
          },
        ),
      ),
    );
  }

  //  增加WidgetRef
  _sendMessage(WidgetRef ref, TextEditingController controller) {
    final content = controller.text;
    final message = Message(
      id: uuid.v4(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );
    // messages.add(message);
    ref.read(messageProvider.notifier).upsertMessage(message); // 添加消息
    controller.clear();

    _requestStreamChatGPT(ref, content);
  }

  // 请求chatgpt
  _requestChatGPT(WidgetRef ref, String content) async {
    // 禁用ui状态
    ref.read(chatUiProvider.notifier).setRequestLoading(true);
    try {
      final id = uuid.v4();
      final res = await chatgpt.sendChat(content);
      final text = res.choices.first.message?.content ?? "";
      final message = Message(
        id: id,
        content: text,
        isUser: false,
        timestamp: DateTime.now(),
      );

      ref.read(messageProvider.notifier).addMessage(message);
    } catch (err) {
      logger.e("requestChatGPT error: $err", err);
    } finally {
      // 启用ui状态
      ref.read(chatUiProvider.notifier).setRequestLoading(false);
    }
  }

  // 请求chatgpt
  _requestStreamChatGPT(WidgetRef ref, String content) async {
    // 禁用ui状态
    ref.read(chatUiProvider.notifier).setRequestLoading(true);
    try {
      final id = uuid.v4();
      await chatgpt.streamChat(
        content,
        onSuccess: (text) {
          final message = Message(
            id: id,
            content: text,
            isUser: false,
            timestamp: DateTime.now(),
          );

          ref.read(messageProvider.notifier).upsertMessage(message);
        },
      );
    } catch (err) {
      logger.e("requestStreamChatGPT error: $err", err);
    } finally {
      // 启用ui状态
      ref.read(chatUiProvider.notifier).setRequestLoading(false);
    }
  }
}
