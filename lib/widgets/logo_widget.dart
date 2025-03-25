import 'package:flutter/material.dart';
import '/theme/app_theme.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final bool showTagline;

  const LogoWidget({
    super.key,
    this.size = 120,
    this.showTagline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo image
        Image.asset(
          'images/logo.png',
          width: 318,
          height: 244,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class PersonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw a simple person silhouette
    final Path path = Path()
      ..moveTo(size.width / 2, 0) // Head top
      ..arcTo(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height * 0.15),
          radius: size.width * 0.15,
        ),
        0,
        2 * 3.14,
        false,
      ) // Head
      ..moveTo(size.width / 2, size.height * 0.3) // Neck top
      ..lineTo(size.width / 2, size.height * 0.6) // Body
      ..lineTo(size.width * 0.3, size.height) // Left leg
      ..moveTo(size.width / 2, size.height * 0.6) // Back to body
      ..lineTo(size.width * 0.7, size.height) // Right leg
      ..moveTo(size.width / 2, size.height * 0.4) // Arms start
      ..lineTo(size.width * 0.2, size.height * 0.5) // Left arm
      ..moveTo(size.width / 2, size.height * 0.4) // Back to arms start
      ..lineTo(size.width * 0.8, size.height * 0.5); // Right arm

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
