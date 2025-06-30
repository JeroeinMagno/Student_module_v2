import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../constants/constants.dart';

class AnimatedLogo extends StatelessWidget {
  final Animation<double> pulseAnimation;

  const AnimatedLogo({
    super.key,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1200),
      child: AnimatedBuilder(
        animation: pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: pulseAnimation.value,
            child: SizedBox(
              width: 140.w,
              height: 140.w,
              child: SvgPicture.asset(
                AppAssets.bsuLogo,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
