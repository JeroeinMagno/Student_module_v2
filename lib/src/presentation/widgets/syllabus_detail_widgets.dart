import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyllabusTab extends ConsumerWidget {
  final String courseId;

  const SyllabusTab({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Overview
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            children: [
              CriteriaProgressChart(),
              GradeOverviewCard(),
            ],
          ),
          SizedBox(height: 24.h),
          
          // Tables Section
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            children: [
              TopicsTable(),
              LearningOutcomesTable(),
            ],
          ),
        ],
      ),
    );
  }
}

class CriteriaProgressChart extends StatelessWidget {
  const CriteriaProgressChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Criteria Progress',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProgressIndicator(
                    context,
                    'Knowledge',
                    85,
                    const Color(0xFF6B9B8A),
                  ),
                  SizedBox(height: 16.h),
                  _buildProgressIndicator(
                    context,
                    'Skills',
                    92,
                    const Color(0xFF9BC9B8),
                  ),
                  SizedBox(height: 16.h),
                  _buildProgressIndicator(
                    context,
                    'Application',
                    78,
                    const Color(0xFFE8A87C),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),            _buildLegend(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(
    BuildContext context,
    String label,
    int percentage,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$percentage%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: color.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(
          context,
          const Color(0xFF6B9B8A),
          'Knowledge (85%)',
        ),
        SizedBox(width: 16.w),
        _buildLegendItem(
          context,
          const Color(0xFF9BC9B8),
          'Skills (92%)',
        ),
        SizedBox(width: 16.w),
        _buildLegendItem(
          context,
          const Color(0xFFE8A87C),
          'Application (78%)',
        ),
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class GradeOverviewCard extends StatelessWidget {
  const GradeOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grade Overview',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF6B9B8A),
                          width: 8.w,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '85',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6B9B8A),
                              ),
                            ),
                            Text(
                              'out of 100',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Current Grade: B+',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicsTable extends StatelessWidget {
  const TopicsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      {'name': 'Introduction to Programming', 'status': 'Completed', 'progress': 100},
      {'name': 'Data Structures', 'status': 'In Progress', 'progress': 75},
      {'name': 'Algorithms', 'status': 'Upcoming', 'progress': 0},
      {'name': 'Object-Oriented Programming', 'status': 'Upcoming', 'progress': 0},
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Topics',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: topics
                      .map((topic) => _buildTopicRow(context, topic))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicRow(BuildContext context, Map<String, dynamic> topic) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic['name'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  topic['status'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(topic['status']),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            '${topic['progress']}%',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return const Color(0xFF4CAF50);
      case 'In Progress':
        return const Color(0xFFFF9800);
      case 'Upcoming':
        return const Color(0xFF9E9E9E);
      default:
        return const Color(0xFF9E9E9E);
    }
  }
}

class LearningOutcomesTable extends StatelessWidget {
  const LearningOutcomesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final outcomes = [
      {'name': 'Understand basic programming concepts', 'achieved': true},
      {'name': 'Implement data structures', 'achieved': true},
      {'name': 'Analyze algorithm complexity', 'achieved': false},
      {'name': 'Apply OOP principles', 'achieved': false},
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Outcomes',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: outcomes
                      .map((outcome) => _buildOutcomeRow(context, outcome))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutcomeRow(BuildContext context, Map<String, dynamic> outcome) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            outcome['achieved'] ? Icons.check_circle : Icons.radio_button_unchecked,
            color: outcome['achieved'] 
                ? const Color(0xFF4CAF50) 
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            size: 20.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              outcome['name'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                decoration: outcome['achieved'] 
                    ? TextDecoration.lineThrough 
                    : TextDecoration.none,
                color: outcome['achieved']
                    ? Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
