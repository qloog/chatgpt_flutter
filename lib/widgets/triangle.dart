import 'package:flutter/cupertino.dart';

class Triangle extends CustomPainter {
  final Color bgColor;

  Triangle(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;
    var path = Path();

    path.lineTo(0, 0);
    path.lineTo(5, 10);
    path.lineTo(10, 0);
    // move 5 to the left as a whole
    canvas.translate(-5, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
