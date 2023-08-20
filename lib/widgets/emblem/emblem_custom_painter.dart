import 'package:flutter/material.dart';

class EmblemCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.4743190, size.height * 0.2486190);
    path0.cubicTo(
        size.width * 0.4741832,
        size.height * 0.6848669,
        size.width * 0.4741832,
        size.height * 0.6848669,
        size.width * 0.4741379,
        size.height * 0.8302829);
    path0.cubicTo(
        size.width * 0.4749914,
        size.height * 0.8864393,
        size.width * 0.5507328,
        size.height * 0.8503661,
        size.width * 0.6025862,
        size.height * 0.9134775);
    path0.cubicTo(
        size.width * 0.6579052,
        size.height * 0.8500000,
        size.width * 0.7330086,
        size.height * 0.8879700,
        size.width * 0.7318966,
        size.height * 0.8286190);
    path0.quadraticBezierTo(size.width * 0.7322565, size.height * 0.6840849,
        size.width * 0.7333362, size.height * 0.2504825);
    path0.quadraticBezierTo(size.width * 0.6685819, size.height * 0.2500166,
        size.width * 0.4743190, size.height * 0.2486190);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class EmblemClipper extends CustomClipper<Path> {
  double radius = 10, tw = 20, th = 10;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, th + radius);
    path.arcToPoint(Offset(size.width - radius, th),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(radius + 10 + tw, th);
    path.lineTo(radius + 10 + tw / 2,
        0); //in these lines, the 10 is to have a space of 10 between the top-left corner curve and the triangle
    path.lineTo(radius + 10, th);
    path.lineTo(radius, th);
    path.arcToPoint(Offset(0, th + radius),
        radius: Radius.circular(radius), clockwise: false);

    return path;
  }

  @override
  bool shouldReclip(EmblemClipper oldClipper) => true;
}
