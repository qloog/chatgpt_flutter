import 'package:chatgpt/markdown/latex.dart';
import 'package:chatgpt/widgets/typing_cursor.dart';
import 'package:flutter/cupertino.dart';
import 'package:markdown_widget/config/markdown_generator.dart';

import '../models/message.dart';

class MessageContentWidget extends StatelessWidget {
  final bool typing;
  const MessageContentWidget({
    Key? key,
    required this.message,
    this.typing = false,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
        // 设置为左对齐
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...MarkdownGenerator(
            generators: [
              latexGenerator,
            ],
            inlineSyntaxes: [
              LatexSyntax(),
            ],
          ).buildWidgets(message.content),
          if (typing) const TypingCursor(),
        ]);
  }
}
