import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Logo widget for the login screen
class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.red.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: SvgPicture.asset(
          'assets/icons/bsulogo.svg',
          width: 56.w,
          height: 56.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
