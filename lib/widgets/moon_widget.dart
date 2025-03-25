import 'package:flutter/material.dart';
import '/theme/app_theme.dart';

class MoonWidget extends StatelessWidget {
  final double size;
  
  const MoonWidget({
    super.key, 
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Moon crescent shape
          ClipPath(
            clipper: MoonClipper(),
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: AppTheme.backgroundColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Stars
          Positioned(
            top: size * 0.3,
            left: size * 0.3,
            child: Icon(
              Icons.star,
              color: Colors.yellow,
              size: size * 0.15,
            ),
          ),
          Positioned(
            top: size * 0.5,
            right: size * 0.3,
            child: Icon(
              Icons.star,
              color: Colors.yellow,
              size: size * 0.15,
            ),
          ),
          // Clouds
          Positioned(
            bottom: size * 0.1,
            left: -size * 0.2,
            child: CustomPaint(
              size: Size(size * 0.7, size * 0.3),
              painter: CloudPainter(color: Colors.white.withOpacity(0.7)),
            ),
          ),
          Positioned(
            bottom: -size * 0.05,
            right: -size * 0.1,
            child: CustomPaint(
              size: Size(size * 0.6, size * 0.25),
              painter: CloudPainter(color: Colors.white.withOpacity(0.7)),
            ),
          ),
        ],
      ),
    );
  }
}

class MoonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    
    // Create a crescent moon shape
    path.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.7, size.height * 0.5),
      radius: size.width * 0.6,
    ));
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CloudPainter extends CustomPainter {
  final Color color;
  
  CloudPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final double circleRadius = size.height * 0.5;
    
    // Draw a simple cloud shape using circles
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.5),
      circleRadius,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.3),
      circleRadius * 0.8,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.5),
      circleRadius,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.6),
      circleRadius * 0.7,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

