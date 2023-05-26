import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:chatgpt/states/chat_ui_state.dart';

import 'package:chatgpt/injection.dart';
import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/states/message_state.dart';

import '../models/session.dart';
import '../states/session_state.dart';

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
  _sendMessage(WidgetRef ref, TextEditingController controller) async {
    final content = controller.text;
    Message message = _createMessage(content);

    var active = ref.watch(activeSessionProvider);
    var sessionId = active?.id ?? 0;
    if (sessionId <= 0) {
      active = Session(title: content);
      // final id = await db.sessionDao.upsertSession(active);
      active = await ref
          .read(sessionStateNotifierProvider.notifier)
          .upsertSession(active);
      sessionId = active.id!;
      ref
          .read(sessionStateNotifierProvider.notifier)
          .setActiveSession(active.copyWith(id: sessionId));
    }

    ref.read(messageProvider.notifier).upsertMessage(
          message.copyWith(sessionId: sessionId),
        ); // 添加消息
    controller.clear();

    _requestStreamChatGPT(ref, content, sessionId);
  }

  Message _createMessage(
    String content, {
    String? id,
    bool isUser = true,
    int? sessionId,
  }) {
    final message = Message(
      id: id ?? uuid.v4(),
      content: content,
      isUser: isUser,
      timestamp: DateTime.now(),
      sessionId: sessionId ?? 0,
    );
    return message;
  }

  // 请求chatgpt
  _requestChatGPT(WidgetRef ref, String content) async {
    // 禁用ui状态
    ref.read(chatUiProvider.notifier).setRequestLoading(true);
    try {
      final id = uuid.v4();
      final res = await chatgpt.sendChat(content);
      final text = res.choices.first.message?.content ?? "";
      final message = _createMessage(text, id: id, isUser: false, sessionId: 0);

      ref.read(messageProvider.notifier).addMessage(message);
    } catch (err) {
      logger.e("requestChatGPT error: $err", err);
    } finally {
      // 启用ui状态
      ref.read(chatUiProvider.notifier).setRequestLoading(false);
    }
  }

  // 请求chatgpt
  _requestStreamChatGPT(WidgetRef ref, String content, int? sessionId) async {
    // 禁用ui状态
    ref.read(chatUiProvider.notifier).setRequestLoading(true);
    try {
      final id = uuid.v4();
      final messages = ref.watch(activeSessionMessagesProvider);
      await chatgpt.streamChat(
        messages,
        onSuccess: (text) {
          final message =
              _createMessage(text, id: id, isUser: false, sessionId: sessionId);

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
