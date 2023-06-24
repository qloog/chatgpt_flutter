import 'package:chatgpt/widgets/chat_history.dart';
import 'package:chatgpt/widgets/chat_screen.dart';
import 'package:chatgpt/widgets/desktop.dart';
import 'package:chatgpt/widgets/new_chat_button.dart';
import 'package:chatgpt/widgets/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../states/session_state.dart';

class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesktopWindow(
        child: Row(
          children: [
            SizedBox(
              width: 240,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const NewChatButton(),
                  const SizedBox(height: 8),
                  const Expanded(
                    child: ChatHistoryWindow(),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                                title: Text("Settings"),
                                content: SizedBox(
                                  height: 400,
                                  width: 400,
                                  child: SettingsWindow(),
                                ));
                          });
                    },
                  ),
                ],
              ),
            ),
            const Expanded(child: ChatScreen()),
          ],
        ),
      ),
    );
  }
}

// 移动端首页
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

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
          ),
          IconButton(
            onPressed: () {
              ref
                  .read(sessionStateNotifierProvider.notifier)
                  .setActiveSession(null);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
              onPressed: () {
                GoRouter.of(context).push('/settings');
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: const ChatScreen(),
    );
  }
}
