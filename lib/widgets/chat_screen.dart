import 'package:chatgpt/models/message.dart';
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
                separatorBuilder:(context, index) => const Divider(
                  height: 16,
                ),
              ),
            ),

            // 输入框
            TextField(
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
    final message = Message(content: content, isUser: true, timestamp: DateTime.now());
    // messages.add(message);
    ref.read(messageProvider.notifier).addMessage(message); // 添加消息
    _textController.clear();
  }
}