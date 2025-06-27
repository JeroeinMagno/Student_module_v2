import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Captcha placeholder widget for the login screen
class LoginCaptchaPlaceholder extends StatelessWidget {
  const LoginCaptchaPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            "I'm not a robot",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[800],
            ),
          ),
          const Spacer(),
          Icon(
            Icons.refresh,
            size: 20.sp,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}
