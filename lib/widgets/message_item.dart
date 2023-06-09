import 'package:chatgpt/widgets/message_content.dart';
import 'package:chatgpt/widgets/triangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/message.dart';

class ReceivedMessageItem extends StatelessWidget {
  final Color backgroundColor;
  final double radius;
  final bool typing;

  const ReceivedMessageItem({
    super.key,
    required this.message,
    this.backgroundColor = Colors.white,
    this.radius = 8,
    this.typing = false,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Container(
            color: Colors.white,
            child: SvgPicture.asset(
              "assets/images/chatgpt.png",
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        CustomPaint(
          painter: Triangle(backgroundColor),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.only(right: 48),
            child: MessageContentWidget(
              message: message,
              typing: typing,
            ),
          ),
        ),
      ],
    );
  }
}

class SentMessageItem extends StatelessWidget {
  final Color backgroundColor;
  final double radius;

  const SentMessageItem({
    super.key,
    required this.message,
    this.backgroundColor = Colors.white,
    this.radius = 8,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.only(left: 48),
            child: MessageContentWidget(
              message: message,
            ),
          ),
        ),
        CustomPaint(
          painter: Triangle(backgroundColor),
        ),
        const SizedBox(
          width: 8,
        ),
        const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            'A',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
