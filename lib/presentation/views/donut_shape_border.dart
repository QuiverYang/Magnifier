import 'dart:math';

import 'package:flutter/material.dart';

class StarShapeBorder extends ShapeBorder {
  final Path _path = Path();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => nStarPath(
        5,
        rect.height / 2,
        rect.height / 2 * 0.5,
        dx: rect.width / 2,
        dy: rect.height / 2,
      );

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 2;
    canvas.drawPath(getOuterPath(rect), paint);
  }

  Path nStarPath(int num, double R, double r, {double dx = 0, double dy = 0}) {
    final perRad = 2 * pi / num;
    final radA = perRad / 2 / 2;
    final radB = 2 * pi / (num - 1) / 2 - radA / 2 + radA;
    _path.moveTo(cos(radA) * R + dx, -sin(radA) * R + dy);
    for (var i = 0; i < num; i++) {
      _path
        ..lineTo(
          cos(radA + perRad * i) * R + dx,
          -sin(radA + perRad * i) * R + dy,
        )
        ..lineTo(
          cos(radB + perRad * i) * r + dx,
          -sin(radB + perRad * i) * r + dy,
        );
    }
    _path.close();
    return _path;
  }

  @override
  ShapeBorder scale(double t) => this;
}

class DoubleRingCircleBorder extends ShapeBorder {
  const DoubleRingCircleBorder({
    this.outerColor = Colors.black,
    this.innerColor = Colors.white,
    this.outerWidth = 1.0,
    this.innerWidth = 1.0,
  });

  final Color outerColor;
  final Color innerColor;
  final double outerWidth;
  final double innerWidth;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addOval(rect);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path()..addOval(rect);
    final innerRect = Rect.fromCircle(
      center: rect.center,
      radius: rect.width / 2 - outerWidth - innerWidth,
    );
    path.addOval(innerRect);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final outerPaint = Paint()
      ..color = outerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerWidth;

    final innerPaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = innerWidth;

    canvas.drawOval(rect, outerPaint);

    final innerRect = Rect.fromCircle(
      center: rect.center,
      radius: rect.width / 2 - outerWidth - innerWidth,
    );
    canvas.drawOval(innerRect, innerPaint);
  }

  @override
  ShapeBorder scale(double t) {
    return DoubleRingCircleBorder(
      outerColor: outerColor,
      innerColor: innerColor,
      outerWidth: outerWidth * t,
      innerWidth: innerWidth * t,
    );
  }
}
