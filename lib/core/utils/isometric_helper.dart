import 'package:flutter/material.dart';

/// Helper widget for positioning isometric room objects
/// Uses fractional positioning (0.0 to 1.0) for responsive scaling
class IsometricObject extends StatelessWidget {
  final double leftFraction; // 0.0 (left edge) to 1.0 (right edge)
  final double topFraction; // 0.0 (top edge) to 1.0 (bottom edge)
  final double widthFraction; // Width as fraction of screen width
  final double heightFraction; // Height as fraction of screen height
  final Widget child;

  const IsometricObject({
    super.key,
    required this.leftFraction,
    required this.topFraction,
    required this.widthFraction,
    required this.heightFraction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size directly from MediaQuery for proper responsive scaling
    final screenSize = MediaQuery.of(context).size;
    
    return Positioned(
      left: screenSize.width * leftFraction,
      top: screenSize.height * topFraction,
      width: screenSize.width * widthFraction,
      height: screenSize.height * heightFraction,
      child: child,
    );
  }
}

/// Room object configuration for easier management
class RoomObjectConfig {
  final String label;
  final double leftFraction;
  final double topFraction;
  final double widthFraction;
  final double heightFraction;
  final IconData placeholderIcon;
  final Color placeholderColor;
  final VoidCallback onTap;

  const RoomObjectConfig({
    required this.label,
    required this.leftFraction,
    required this.topFraction,
    required this.widthFraction,
    required this.heightFraction,
    required this.placeholderIcon,
    required this.placeholderColor,
    required this.onTap,
  });
}
