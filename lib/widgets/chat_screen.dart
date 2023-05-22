import 'package:chatgpt/models/message.dart';
import 'package:chatgpt/injection.dart';
import 'package:chatgpt/states/chat_ui_state.dart';
import 'package:chatgpt/states/message_state.dart';
import 'package:chatgpt/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatScreen extends HookConsumerWidget {
  ChatScreen({super.key});

  final List<Message> messages = [
    Message(content: "Hello ya", isUser: true, timestamp: DateTime.now()),
    Message(content: "How are you?", isUser: false, timestamp: DateTime.now()),
    Message(
        content: "Fine,Thank you. And you?",
        isUser: true,
        timestamp: DateTime.now()),
    Message(content: "I am fine.", isUser: false, timestamp: DateTime.now()),
  ];

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messageProvider); // 获取数据
    final chatUIState = ref.watch(chatUiProvider); // 获取ui状态

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return MessageItem(message: messages[index]);
                },
                itemCount: messages.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 16,
                ),
              ),
            ),

            // 输入框
            TextField(
              enabled: !chatUIState.requestLoading,
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Type a message",
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                  ),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _sendMessage(ref, _textController.text);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  增加WidgetRef
  _sendMessage(WidgetRef ref, String content) {
    final message =
        Message(content: content, isUser: true, timestamp: DateTime.now());
    // messages.add(message);
    ref.read(messageProvider.notifier).addMessage(message); // 添加消息
    _textController.clear();

    _requestChatGPT(ref, content);
  }

  // 请求chatgpt
  _requestChatGPT(WidgetRef ref, String content) async {
    // 禁用ui状态
    ref.read(chatUiProvider.notifier).setRequestLoading(true);
    try {
      final res = await chatgpt.sendChat(content);
      final text = res.choices.first.message?.content ?? "";
      final message =
          Message(content: text, isUser: false, timestamp: DateTime.now());

      ref.read(messageProvider.notifier).addMessage(message);
    } catch (err) {
      logger.e("requestChatGPT error: $err", err);
    } finally {
      // 启用ui状态
      ref.read(chatUiProvider.notifier).setRequestLoading(false);
    }
  }
}
