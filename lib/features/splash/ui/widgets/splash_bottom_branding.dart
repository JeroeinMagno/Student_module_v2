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
              'Powered by BSU IT Department',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Version 2.0',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white.withOpacity(0.4),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
