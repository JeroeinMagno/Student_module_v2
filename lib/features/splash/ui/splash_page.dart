import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constants/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToHome();
  }

  void _initializeAnimations() {
    // Pulse animation for the logo background
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Rotation animation for decorative elements
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // Start animations
    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      // Navigate to login after splash screen
      context.go('/login');
      // context.go('/dashboard'); // Temporarily disabled - skip to dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3A8A), // Deep blue
              Color(0xFF3B82F6), // Blue
              Color(0xFF6366F1), // Indigo
              Color(0xFF8B5CF6), // Purple
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background elements
            _buildBackgroundElements(),
            
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // University Logo with animation
                  _buildAnimatedLogo(),
                  
                  SizedBox(height: 40.h),
                  
                  // University name with typewriter effect
                  _buildUniversityName(),
                  
                  SizedBox(height: 16.h),
                  
                  // Subtitle
                  _buildSubtitle(),
                  
                  SizedBox(height: 60.h),
                  
                  // Modern loading indicator
                  _buildLoadingIndicator(),
                  
                  SizedBox(height: 20.h),
                  
                  // Loading text
                  _buildLoadingText(),
                ],
              ),
            ),
            
            // Bottom branding
            _buildBottomBranding(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        // Floating academic icons
        Positioned(
          top: 100.h,
          left: 30.w,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 1500),
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Icon(
                    Icons.school,
                    size: 40.sp,
                    color: Colors.white.withOpacity(0.1),
                  ),
                );
              },
            ),
          ),
        ),
        
        Positioned(
          top: 200.h,
          right: 50.w,
          child: FadeInRight(
            duration: const Duration(milliseconds: 1800),
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: -_rotationAnimation.value * 0.5,
                  child: Icon(
                    Icons.menu_book,
                    size: 35.sp,
                    color: Colors.white.withOpacity(0.08),
                  ),
                );
              },
            ),
          ),
        ),
        
        Positioned(
          bottom: 200.h,
          left: 50.w,
          child: FadeInLeft(
            duration: const Duration(milliseconds: 2000),
            delay: const Duration(milliseconds: 500),
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 0.3,
                  child: Icon(
                    Icons.science,
                    size: 30.sp,
                    color: Colors.white.withOpacity(0.06),
                  ),
                );
              },
            ),
          ),
        ),
        
        Positioned(
          bottom: 150.h,
          right: 40.w,
          child: FadeInRight(
            duration: const Duration(milliseconds: 1600),
            delay: const Duration(milliseconds: 800),
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: -_rotationAnimation.value * 0.7,
                  child: Icon(
                    Icons.psychology,
                    size: 28.sp,
                    color: Colors.white.withOpacity(0.05),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedLogo() {
    return FadeInDown(
      duration: const Duration(milliseconds: 1200),
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Color(0xFFF8FAFC),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(25.w),
                child: SvgPicture.asset(
                  AppAssets.bsuLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
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
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 2),
              blurRadius: 4,
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
          color: Colors.white.withOpacity(0.9),
          letterSpacing: 0.8,
          fontWeight: FontWeight.w300,
        ),
      ),
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
          color: Colors.white.withOpacity(0.7),
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildBottomBranding() {
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
