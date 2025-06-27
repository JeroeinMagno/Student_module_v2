import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';

/// Animated decorative circles for the splash screen background
class AnimatedDecorativeCircles extends StatelessWidget {
  final Animation<double> rotationAnimation;

  const AnimatedDecorativeCircles({
    super.key,
    required this.rotationAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotationAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Large background circle
            Positioned(
              top: -100,
              left: -50,
              child: Transform.rotate(
                angle: rotationAnimation.value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.secondary.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Medium circle
            Positioned(
              bottom: -80,
              right: -60,
              child: Transform.rotate(
                angle: -rotationAnimation.value * 0.8,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.secondary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Small decorative circles
            Positioned(
              top: 100,
              right: 50,
              child: Transform.rotate(
                angle: rotationAnimation.value * 1.5,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
