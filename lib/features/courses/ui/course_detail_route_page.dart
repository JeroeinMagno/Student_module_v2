import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../components/components.dart';

/// Course detail page for routing (takes courseId and fetches course data)
class CourseDetailRoutePage extends StatefulWidget {
  final String courseId;

  const CourseDetailRoutePage({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailRoutePage> createState() => _CourseDetailRoutePageState();
}

class _CourseDetailRoutePageState extends State<CourseDetailRoutePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Course Details'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Course Info'),
            Tab(text: 'Syllabus'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCourseInfo(),
          _buildSyllabus(),
        ],
      ),
    );
  }

  Widget _buildCourseInfo() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Information',
                    style: AppTextStyles.heading5,
                  ),
                  SizedBox(height: AppDimensions.paddingMD),
                  _buildInfoRow('Course ID', widget.courseId),
                  _buildInfoRow('Course Name', 'Sample Course'),
                  _buildInfoRow('Instructor', 'Dr. Sample'),
                  _buildInfoRow('Units', '3'),
                  _buildInfoRow('Schedule', 'MWF 10:00-11:00 AM'),
                ],
              ),
            ),
          ),
          SizedBox(height: AppDimensions.paddingMD),
          AppCard(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.paddingMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress',
                    style: AppTextStyles.heading5,
                  ),
                  SizedBox(height: AppDimensions.paddingMD),
                  CourseProgressBar(
                    courseCode: widget.courseId,
                    progress: 0.75,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyllabus() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimensions.paddingMD),
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course Syllabus',
                style: AppTextStyles.heading5,
              ),
              SizedBox(height: AppDimensions.paddingMD),
              Text(
                'This is a placeholder for the course syllabus content. In the full implementation, this would show the detailed syllabus for course ${widget.courseId}.',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimensions.paddingSM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: AppTextStyles.labelMedium,
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
}
