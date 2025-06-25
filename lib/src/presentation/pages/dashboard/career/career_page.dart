import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/app_sidebar.dart';
import '../../../widgets/custom_app_bar.dart';

class CareerPage extends ConsumerStatefulWidget {
  const CareerPage({super.key});

  @override
  ConsumerState<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends ConsumerState<CareerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,      appBar: CustomAppBar(
        title: 'Career',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: AppSidebar(
        onDashboardSelected: () {
          Navigator.pop(context);
          // Navigate to dashboard
        },
        onPerformanceSelected: () {
          Navigator.pop(context);
          // Navigate to performance page
        },
      ),      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Career Opportunities',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCareerCard(
                        context,
                        'Software Engineering',
                        'Build innovative software solutions',
                        Icons.computer,
                        const Color(0xFF6B9B8A),
                      ),
                      SizedBox(height: 16.h),
                      _buildCareerCard(
                        context,
                        'Data Science',
                        'Analyze and interpret complex data',
                        Icons.analytics,
                        const Color(0xFF9BC9B8),
                      ),
                      SizedBox(height: 16.h),
                      _buildCareerCard(
                        context,
                        'Product Management',
                        'Lead product development initiatives',
                        Icons.inventory,
                        const Color(0xFFE8A87C),
                      ),
                      SizedBox(height: 16.h),
                      _buildCareerCard(
                        context,
                        'UX/UI Design',
                        'Create intuitive user experiences',
                        Icons.design_services,
                        const Color(0xFF6B9B8A),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareerCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to career details
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30.sp,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
