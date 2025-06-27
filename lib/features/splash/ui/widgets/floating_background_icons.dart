import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class FloatingBackgroundIcons extends StatelessWidget {
  final Animation<double> rotationAnimation;

  const FloatingBackgroundIcons({
    super.key,
    required this.rotationAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildFloatingIcon(
          top: 100.h,
          left: 30.w,
          icon: Icons.school,
          size: 40.sp,
          opacity: 0.1,
          rotation: 1.0,
          duration: 1500,
          fadeDirection: FadeDirection.left,
        ),
        _buildFloatingIcon(
          top: 200.h,
          right: 50.w,
          icon: Icons.menu_book,
          size: 35.sp,
          opacity: 0.08,
          rotation: -0.5,
          duration: 1800,
          fadeDirection: FadeDirection.right,
        ),
        _buildFloatingIcon(
          bottom: 200.h,
          left: 50.w,
          icon: Icons.science,
          size: 30.sp,
          opacity: 0.06,
          rotation: 0.3,
          duration: 2000,
          delay: 500,
          fadeDirection: FadeDirection.left,
        ),
        _buildFloatingIcon(
          bottom: 150.h,
          right: 40.w,
          icon: Icons.psychology,
          size: 28.sp,
          opacity: 0.05,
          rotation: -0.7,
          duration: 1600,
          delay: 800,
          fadeDirection: FadeDirection.right,
        ),
      ],
    );
  }

  Widget _buildFloatingIcon({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required IconData icon,
    required double size,
    required double opacity,
    required double rotation,
    required int duration,
    int delay = 0,
    required FadeDirection fadeDirection,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: _buildFadeWidget(
        duration: Duration(milliseconds: duration),
        delay: Duration(milliseconds: delay),
        fadeDirection: fadeDirection,
        child: AnimatedBuilder(
          animation: rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: rotationAnimation.value * rotation,
              child: Icon(
                icon,
                size: size,
                color: Colors.white.withOpacity(opacity),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFadeWidget({
    required Duration duration,
    required Duration delay,
    required FadeDirection fadeDirection,
    required Widget child,
  }) {
    switch (fadeDirection) {
      case FadeDirection.left:
        return FadeInLeft(
          duration: duration,
          delay: delay,
          child: child,
        );
      case FadeDirection.right:
        return FadeInRight(
          duration: duration,
          delay: delay,
          child: child,
        );
    }
  }
}

enum FadeDirection { left, right }
