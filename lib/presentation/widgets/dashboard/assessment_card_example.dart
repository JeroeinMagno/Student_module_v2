import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';
import '../../../core/state/providers/assessments_provider.dart';
import 'assessment_card.dart';

/// Example page demonstrating the new Assessment Card with toggle functionality
class AssessmentCardExample extends StatelessWidget {
  const AssessmentCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Card Demo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.paddingMD),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modern Assessment Card',
              style: AppTextStyles.heading4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            Text(
              'Toggle between Completed and In Progress assessments with a modern, scalable design.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingLG),
            
            // Assessment Card
            AssessmentCard(
              assessments: _generateSampleAssessments(),
              title: 'Student Assessments',
              subtitle: 'View your completed and in-progress assessments',
              onAssessmentTap: (assessment) {
                _showAssessmentDetails(context, assessment);
              },
            ),
            
            SizedBox(height: AppDimensions.paddingLG),
            
            // Feature highlights
            AppCard(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.paddingMD),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features',
                      style: AppTextStyles.heading6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingSM),
                    _buildFeatureItem('✅ Toggle between Completed and In Progress'),
                    _buildFeatureItem('🎨 Modern dark theme design'),
                    _buildFeatureItem('📱 Responsive and scalable'),
                    _buildFeatureItem('🔧 Modular component architecture'),
                    _buildFeatureItem('🎯 Status-based filtering'),
                    _buildFeatureItem('📊 Real-time score display'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: AppTextStyles.bodyMedium,
      ),
    );
  }

  void _showAssessmentDetails(BuildContext context, Assessment assessment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLG),
            Text(
              assessment.title,
              style: AppTextStyles.heading5.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingSM),
            _buildDetailRow('Course', assessment.courseId),
            _buildDetailRow('Type', assessment.type),
            _buildDetailRow('Status', assessment.status),
            _buildDetailRow('Due Date', assessment.dueDate.toString().split(' ')[0]),
            if (assessment.earnedPoints != null)
              _buildDetailRow('Score', '${((assessment.earnedPoints! / assessment.totalPoints) * 100).toStringAsFixed(1)}%'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              '$label:',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  List<Assessment> _generateSampleAssessments() {
    return [
      // Completed assessments
      Assessment(
        id: 'hist101_quiz1',
        courseId: 'HIST 101',
        title: 'Quiz',
        type: 'quiz',
        description: 'History Quiz 1',
        dueDate: DateTime.now().subtract(const Duration(days: 5)),
        submissionDate: DateTime.now().subtract(const Duration(days: 5)),
        totalPoints: 100,
        earnedPoints: 24,
        status: 'graded',
      ),
      Assessment(
        id: 'hist101_quiz2',
        courseId: 'HIST 101',
        title: 'Quiz',
        type: 'quiz',
        description: 'History Quiz 2',
        dueDate: DateTime.now().subtract(const Duration(days: 3)),
        submissionDate: DateTime.now().subtract(const Duration(days: 3)),
        totalPoints: 100,
        earnedPoints: 21,
        status: 'graded',
      ),
      Assessment(
        id: 'hist101_midterms',
        courseId: 'HIST 101',
        title: 'Midterms',
        type: 'exam',
        description: 'History Midterm Exam',
        dueDate: DateTime.now().subtract(const Duration(days: 10)),
        submissionDate: DateTime.now().subtract(const Duration(days: 10)),
        totalPoints: 100,
        earnedPoints: 20,
        status: 'graded',
      ),
      Assessment(
        id: 'hist101_finals',
        courseId: 'HIST 101',
        title: 'Finals',
        type: 'exam',
        description: 'History Final Exam',
        dueDate: DateTime.now().subtract(const Duration(days: 1)),
        submissionDate: DateTime.now().subtract(const Duration(days: 1)),
        totalPoints: 100,
        earnedPoints: 22,
        status: 'graded',
      ),
      Assessment(
        id: 'phy101_quiz1',
        courseId: 'PHY 101',
        title: 'Quiz',
        type: 'quiz',
        description: 'Physics Quiz 1',
        dueDate: DateTime.now().subtract(const Duration(days: 7)),
        submissionDate: DateTime.now().subtract(const Duration(days: 7)),
        totalPoints: 100,
        earnedPoints: 27,
        status: 'graded',
      ),
      Assessment(
        id: 'phy101_quiz2',
        courseId: 'PHY 101',
        title: 'Quiz',
        type: 'quiz',
        description: 'Physics Quiz 2',
        dueDate: DateTime.now().subtract(const Duration(days: 4)),
        submissionDate: DateTime.now().subtract(const Duration(days: 4)),
        totalPoints: 100,
        earnedPoints: 23,
        status: 'graded',
      ),
      Assessment(
        id: 'phy101_midterms',
        courseId: 'PHY 101',
        title: 'Midterms',
        type: 'exam',
        description: 'Physics Midterm Exam',
        dueDate: DateTime.now().subtract(const Duration(days: 8)),
        submissionDate: DateTime.now().subtract(const Duration(days: 8)),
        totalPoints: 100,
        earnedPoints: 19,
        status: 'graded',
      ),
      Assessment(
        id: 'phy101_finals',
        courseId: 'PHY 101',
        title: 'Finals',
        type: 'exam',
        description: 'Physics Final Exam',
        dueDate: DateTime.now().subtract(const Duration(days: 2)),
        submissionDate: DateTime.now().subtract(const Duration(days: 2)),
        totalPoints: 100,
        earnedPoints: 21,
        status: 'graded',
      ),
      Assessment(
        id: 'eng102_quiz1',
        courseId: 'ENG 102',
        title: 'Quiz',
        type: 'quiz',
        description: 'English Quiz 1',
        dueDate: DateTime.now().subtract(const Duration(days: 6)),
        submissionDate: DateTime.now().subtract(const Duration(days: 6)),
        totalPoints: 100,
        earnedPoints: 22,
        status: 'graded',
      ),
      Assessment(
        id: 'eng102_quiz2',
        courseId: 'ENG 102',
        title: 'Quiz',
        type: 'quiz',
        description: 'English Quiz 2',
        dueDate: DateTime.now().subtract(const Duration(days: 3)),
        submissionDate: DateTime.now().subtract(const Duration(days: 3)),
        totalPoints: 100,
        earnedPoints: 19,
        status: 'graded',
      ),
      
      // In progress assessments (no scores yet)
      Assessment(
        id: 'math201_quiz1',
        courseId: 'MATH 201',
        title: 'Quiz',
        type: 'quiz',
        description: 'Mathematics Quiz 1',
        dueDate: DateTime.now().add(const Duration(days: 2)),
        totalPoints: 100,
        status: 'pending',
      ),
      Assessment(
        id: 'cs301_project',
        courseId: 'CS 301',
        title: 'Project',
        type: 'project',
        description: 'Computer Science Project',
        dueDate: DateTime.now().add(const Duration(days: 7)),
        totalPoints: 100,
        status: 'pending',
      ),
      Assessment(
        id: 'bio101_midterms',
        courseId: 'BIO 101',
        title: 'Midterms',
        type: 'exam',
        description: 'Biology Midterm Exam',
        dueDate: DateTime.now().add(const Duration(days: 5)),
        totalPoints: 100,
        status: 'pending',
      ),
    ];
  }
}
