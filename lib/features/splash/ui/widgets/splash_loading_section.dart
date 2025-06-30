import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class SplashLoadingSection extends StatelessWidget {
  const SplashLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLoadingIndicator(),
        SizedBox(height: 20.h),
        _buildLoadingText(),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 1000),
      child: Container(
        width: 200.w,
        height: 4.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.r),
          color: Colors.white.withOpacity(0.2),
        ),
        child: LinearProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.white.withOpacity(0.8),
          ),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildLoadingText() {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 1200),
      child: Text(
        'Loading your academic journey...',
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, 1),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}
