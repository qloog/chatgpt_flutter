import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TypingCursor extends HookWidget {
  const TypingCursor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 初始化动画控制器，设置动画时长为 400 毫秒
    final ac = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );
    // 添加动画监听器，当动画完成时，反转动画，当动画反转完成时，再次正向播放动画
    ac.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ac.reverse();
      } else if (status == AnimationStatus.dismissed) {
        ac.forward();
      }
    });

    // 使用 useAnimation 获取动画的值，然后使用 Opacity 将其应用到 Widget 上
    // 当动画播放完成时，动画的值为 1，当动画反转完成时，动画的值为 0
    final opacity = useAnimation(Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(ac));
    // 当动画不再播放时，正向播放动画, 也就是说，当动画播放完成时，会自动反转动画
    // 这样就可以实现一个来回闪烁的光标
    // 这里要特别注意，需要判断是不是正在播放动画，如果已经正在进行中，就不要再次播放了
    if (!ac.isAnimating) {
      ac.forward();
    }
    return Opacity(
      opacity: opacity,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        width: 6,
        height: 12,
        color: Colors.black,
      ),
    );
  }
}
