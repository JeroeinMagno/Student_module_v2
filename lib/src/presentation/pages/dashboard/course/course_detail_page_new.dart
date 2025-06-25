import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'course_exam_view.dart';

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['name'] ?? 'Course',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              course['code'] ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseExamView(course: course),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
            // Professor and Description
            _buildProfessorSection(context),
            
            SizedBox(height: 24.h),
            
            // Content Cards
            _buildCriteriaCompletion(context),
            
            SizedBox(height: 16.h),
            
            _buildPartialGrade(context),
            
            SizedBox(height: 16.h),
            
            _buildIntendedLearningOutcomes(context),
            
            SizedBox(height: 16.h),
            
            _buildCourseTopics(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessorSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prof. ${course['professor'] ?? 'Jane Doe'}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          course['description'] ?? 'An introduction to computer science concepts, history, and problem solving.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildCriteriaCompletion(BuildContext context) {
    final assessments = [
      {'name': 'Quiz 1', 'completed': true},
      {'name': 'Midterms', 'completed': true},
      {'name': 'Plates', 'completed': true},
      {'name': 'Finals', 'completed': false},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // Left side - Text and requirements
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Criteria Completion',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Track your assessment requirements',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 16.h),
                ...assessments.map((assessment) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        assessment['completed'] as bool 
                            ? Icons.check_circle 
                            : Icons.radio_button_unchecked,
                        color: assessment['completed'] as bool 
                            ? const Color(0xFF4CAF50) 
                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        assessment['name'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Right side - Circular progress
          SizedBox(
            width: 100.w,
            height: 100.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100.w,
                  height: 100.w,
                  child: CircularProgressIndicator(
                    value: 0.75,
                    strokeWidth: 8.w,
                    backgroundColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '75%',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Completed',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartialGrade(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Partial Grade',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Needs Improvement',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Your current grade based on completed assessments only.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(
                '50%',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 48.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                      minHeight: 8.h,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16.sp,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            'This score reflects your current standing based on recorded results only.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntendedLearningOutcomes(BuildContext context) {
    final ilos = [
      {'code': 'ILO1', 'description': 'Understand the fundamentals of programming and computer science.'},
      {'code': 'ILO2', 'description': 'Apply data structures and algorithms to solve problems.'},
      {'code': 'ILO3', 'description': 'Design and analyze efficient algorithms.'},
      {'code': 'ILO4', 'description': 'Demonstrate knowledge of advanced algorithms and software engineering principles.'},
      {'code': 'ILO5', 'description': 'Communicate technical information effectively.'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Intended Learning Outcomes',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4CAF50),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This table lists each ILO and its description.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(4),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Text(
                      'ILO',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Text(
                      'Description',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...ilos.map((ilo) => TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Text(
                      ilo['code']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Text(
                      ilo['description']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseTopics(BuildContext context) {
    final topics = [
      {'weeks': '1', 'topic': 'Introduction to Course', 'ilo': '1', 'so': '1, 2'},
      {'weeks': '2-3', 'topic': 'Fundamentals of Programming', 'ilo': '1, 2', 'so': '1, 3'},
      {'weeks': '4', 'topic': 'Data Structures', 'ilo': '1', 'so': '3, 4'},
      {'weeks': '5-6', 'topic': 'Algorithms', 'ilo': '3', 'so': '4'},
      {'weeks': '7-8', 'topic': 'Advanced Algorithms', 'ilo': '3, 4', 'so': '6'},
      {'weeks': '9', 'topic': 'Software Engineering Principles', 'ilo': '1, 5', 'so': '7'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Topics',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4CAF50),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'This table outlines the weekly topics, intended learning outcomes (ILO), and student outcomes (SO) for the course.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20.w,
              headingRowColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.outline.withOpacity(0.1),
              ),
              columns: [
                DataColumn(
                  label: Text(
                    'Week/s',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Topic',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ILO',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'SO',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: topics.map((topic) => DataRow(
                cells: [
                  DataCell(Text(
                    topic['weeks']!,
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
                  DataCell(Text(
                    topic['topic']!,
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
                  DataCell(Text(
                    topic['ilo']!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                  DataCell(Text(
                    topic['so']!,
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
                ],
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
