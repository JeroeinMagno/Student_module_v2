import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/constants.dart';

/// Captcha placeholder widget
class LoginCaptcha extends StatelessWidget {
  const LoginCaptcha({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.getMuted(context),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.getBorder(context)),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.getBorder(context)),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            "I'm not a robot",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.getForeground(context),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.refresh,
            size: 20.sp,
            color: AppColors.getMutedForeground(context),
          ),
        ],
      ),
    );
  }
}
