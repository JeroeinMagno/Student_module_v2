import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class SplashTextContent extends StatelessWidget {
  const SplashTextContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUniversityName(),
        SizedBox(height: 16.h),
        _buildSubtitle(),
      ],
    );
  }

  Widget _buildUniversityName() {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 400),
      child: Text(
        'Batangas State University',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.5,
          shadows: [
            // Primary shadow for depth
            Shadow(
              color: Colors.black.withOpacity(0.7),
              offset: const Offset(0, 3),
              blurRadius: 8,
            ),
            // Secondary shadow for better contrast
            Shadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 1),
              blurRadius: 4,
            ),
            // Subtle glow effect
            Shadow(
              color: Colors.white.withOpacity(0.2),
              offset: const Offset(0, 0),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return FadeInUp(
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 600),
      child: Text(
        'Student Information System',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.white,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w400,
          shadows: [
            // Enhanced shadow for better readability
            Shadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
            // Additional shadow for depth
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 1),
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}
