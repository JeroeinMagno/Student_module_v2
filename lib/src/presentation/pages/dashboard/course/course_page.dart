import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'course_detail_page_new.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  // This would typically come from a provider or API call
  List<Map<String, dynamic>> userCourses = [];

  @override
  void initState() {
    super.initState();
    _loadUserCourses();
  }

  void _loadUserCourses() {
    // Simulate loading user's courses from centralized data
    // In real implementation, this would fetch from API based on user's enrollment
    setState(() {
      userCourses = [
        {
          'id': 'cs101',
          'name': 'Introduction to Computer Science',
          'code': 'CS 101',
          'progress': 0.75,
          'color': const Color(0xFF2196F3),
          'professor': 'Jane Doe',
          'description': 'An introduction to computer science concepts, history, and problem solving.',
          'semester': '1st Semester',
          'academicYear': '2025-2026',
          'units': 3,
          'grade': 85.5,
        },
        {
          'id': 'math201',
          'name': 'Calculus I',
          'code': 'MATH 201',
          'progress': 0.60,
          'color': const Color(0xFF4CAF50),
          'professor': 'John Smith',
          'description': 'Fundamental concepts of differential calculus.',
          'semester': '1st Semester',
          'academicYear': '2025-2026',
          'units': 3,
          'grade': 78.0,
        },
        {
          'id': 'phy151',
          'name': 'Physics I',
          'code': 'PHY 151',
          'progress': 0.85,
          'color': const Color(0xFFFF9800),
          'professor': 'Maria Garcia',
          'description': 'Introduction to mechanics, thermodynamics, and waves.',
          'semester': '1st Semester',
          'academicYear': '2025-2026',
          'units': 4,
          'grade': 92.0,
        },
        {
          'id': 'eng101',
          'name': 'English Composition',
          'code': 'ENG 101',
          'progress': 0.90,
          'color': const Color(0xFFE91E63),
          'professor': 'Sarah Johnson',
          'description': 'Academic writing and communication skills.',
          'semester': '1st Semester',
          'academicYear': '2025-2026',
          'units': 3,
          'grade': 88.5,
        },
        {
          'id': 'chem101',
          'name': 'General Chemistry',
          'code': 'CHEM 101',
          'progress': 0.45,
          'color': const Color(0xFF9C27B0),
          'professor': 'Dr. Brown',
          'description': 'Basic principles of chemistry and chemical reactions.',
          'semester': '1st Semester',
          'academicYear': '2025-2026',
          'units': 4,
          'grade': 72.0,
        },
        {
          'id': 'pe101',
          'name': 'Physical Education',
          'code': 'PE 101',
          'progress': 1.0,
          'color': const Color(0xFF00BCD4),
          'professor': 'Coach Wilson',
          'description': 'Physical fitness and health education.',
          'semester': '1st Semester',
          'academicYear': '2025-2026',
          'units': 2,
          'grade': 95.0,
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Courses',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '${userCourses.length} courses enrolled',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: userCourses.isEmpty
                  ? _buildEmptyState(context)
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 2.8, // Increased height
                        mainAxisSpacing: 16.h,
                      ),
                      itemCount: userCourses.length,
                      itemBuilder: (context, index) {
                        return _buildCourseCard(context, userCourses[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Courses Found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your enrolled courses will appear here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Map<String, dynamic> course) {
    final color = course['color'] as Color;
    final progress = course['progress'] as double;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(course: course),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Course Color Indicator
              Container(
                width: 4.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              
              SizedBox(width: 16.w),
              
              // Course Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            course['code'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _buildGradeBadge(context, course['grade'] as double),
                      ],
                    ),
                    Text(
                      course['name'] as String,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Prof. ${course['professor']}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Progress',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  Text(
                                    '${(progress * 100).toInt()}%',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: color,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: color.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(color),
                                minHeight: 6.h,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.sp,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradeBadge(BuildContext context, double grade) {
    Color badgeColor;
    String gradeText;

    if (grade >= 90) {
      badgeColor = const Color(0xFF4CAF50);
      gradeText = 'A';
    } else if (grade >= 80) {
      badgeColor = const Color(0xFF2196F3);
      gradeText = 'B';
    } else if (grade >= 70) {
      badgeColor = const Color(0xFFFF9800);
      gradeText = 'C';
    } else if (grade >= 60) {
      badgeColor = const Color(0xFFE91E63);
      gradeText = 'D';
    } else {
      badgeColor = const Color(0xFFF44336);
      gradeText = 'F';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        gradeText,
        style: TextStyle(
          color: badgeColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
