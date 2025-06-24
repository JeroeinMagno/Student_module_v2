import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_chart_widgets.dart';
import 'assessment_table.dart';

class DashboardContent extends ConsumerWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if we should use tablet layout (width > 600px)
        final isTabletLayout = constraints.maxWidth > 600;
        
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First row: Metrics + Charts (following web layout)
                if (isTabletLayout) ...[
                  _buildTabletFirstRow(context),
                  SizedBox(height: 16.h),
                  _buildTabletSecondRow(context),
                ] else ...[
                  _buildMobileLayout(context),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabletFirstRow(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left side: Two metric cards stacked (1/5 of width)
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Total Courses',
                    '6',
                    Icons.book_outlined,
                    const Color(0xFF6B9B8A),
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Average Grade',
                    'A-',
                    Icons.grade_outlined,
                    const Color(0xFF9BC9B8),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          
          // Middle: Bar chart (2/5 of width)
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                ),
              ),
              child: const ChartBarHorizontal(),
            ),
          ),
          SizedBox(width: 16.w),
          
          // Right: Radial chart (2/5 of width)
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                ),
              ),
              child: const ChartRadialStacked(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletSecondRow(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left: Line chart (3/5 of width)
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                ),
              ),
              child: const ChartLineLinear(),
            ),
          ),
          SizedBox(width: 16.w),
          
          // Right: Assessment table (2/5 of width)
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                ),
              ),
              child: const AssessmentTable(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mobile: 2x2 metrics grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          children: [
            _buildMetricCard(
              context,
              'Total Courses',
              '6',
              Icons.book_outlined,
              const Color(0xFF6B9B8A),
            ),
            _buildMetricCard(
              context,
              'Average Grade',
              'A-',
              Icons.grade_outlined,
              const Color(0xFF9BC9B8),
            ),
            _buildMetricCard(
              context,
              'Completed',
              '85%',
              Icons.check_circle_outline,
              const Color(0xFFE8A87C),
            ),
            _buildMetricCard(
              context,
              'Attendance',
              '92%',
              Icons.schedule_outlined,
              const Color(0xFF6B9B8A),
            ),
          ],
        ),
        
        SizedBox(height: 20.h),
        
        // Mobile: Charts stacked vertically
        Container(
          height: 250.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: const ChartBarHorizontal(),
        ),
        
        SizedBox(height: 16.h),
        
        Container(
          height: 300.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: const ChartRadialStacked(),
        ),
        
        SizedBox(height: 16.h),
        
        Container(
          height: 300.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: const ChartLineLinear(),
        ),
        
        SizedBox(height: 16.h),
        
        // Assessment table at bottom
        Container(
          height: 400.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: const AssessmentTable(),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 12.sp,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
