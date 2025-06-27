import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/course.dart';
import '../../../presentation/widgets/course/course_widgets.dart';

class CourseDetailsPage extends StatelessWidget {
  final Course course;

  const CourseDetailsPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1D29) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1A1D29) : const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 24.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction to Computer Science',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              course.code,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Viewing exam...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4ADE80),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'View Exam',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseHeader(
              studentName: 'John Doe',
              courseName: 'Introduction to Computer Science',
              courseCode: course.code,
            ),
            SizedBox(height: 20.h),
            CriteriaCompletionCard(
              completionPercentage: 75.0,
              completedCriteria: const ['Quizzes', 'Midterms'],
              pendingCriteria: const ['Assignments', 'Finals'],
            ),
            SizedBox(height: 16.h),
            PartialGradeCard(
              currentGrade: 50.0,
              gradeStatus: 'Needs Improvement',
            ),
            SizedBox(height: 16.h),
            LearningOutcomesCard(
              learningOutcomes: const [
                {'ilo': 'ILO1', 'description': 'Describe computing fundamentals.'},
                {'ilo': 'ILO2', 'description': 'Apply logical reasoning.'},
              ],
            ),
            SizedBox(height: 16.h),
            CourseTopicsCard(
              courseTopics: const [
                {'week': '1', 'topic': 'History of Computers', 'ilo': 'ILO1, ILO2'},
                {'week': '2-3', 'topic': 'Programming Basics', 'ilo': 'ILO1, ILO2'},
              ],
            ),
          ],
        ),
      ),
    );
  }
}
