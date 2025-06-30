import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class SplashBottomBranding extends StatelessWidget {
  const SplashBottomBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30.h,
      left: 0,
      right: 0,
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        delay: const Duration(milliseconds: 1500),
        child: Column(
          children: [
            Text(
              'Powered by CAIST Department',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  Shadow(
                    offset: const Offset(0, 0),
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Version 2.0',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Shadow(
                    offset: const Offset(0, 0),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
