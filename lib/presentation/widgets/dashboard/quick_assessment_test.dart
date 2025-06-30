import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../presentation/widgets/dashboard/dashboard_widgets.dart';

/// Quick test page to verify the assessment card is working with mock data
class QuickAssessmentTest extends StatelessWidget {
  const QuickAssessmentTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Same mock data as in student_performance_content.dart
    final mockData = [
      {
        'course': 'CS 301',
        'type': 'Midterm Exam',
        'score': 92.0,
        'maxScore': 100.0,
        'date': 'Nov 15, 2024',
        'status': 'Completed',
      },
      {
        'course': 'MATH 301',
        'type': 'Quiz 3',
        'score': 85.0,
        'maxScore': 100.0,
        'date': 'Nov 12, 2024',
        'status': 'Completed',
      },
      {
        'course': 'ENG 301',
        'type': 'Essay',
        'score': 88.0,
        'maxScore': 100.0,
        'date': 'Nov 10, 2024',
        'status': 'Completed',
      },
      {
        'course': 'CS 302',
        'type': 'Project',
        'score': null,
        'maxScore': 100.0,
        'date': 'Nov 20, 2024',
        'status': 'In Progress',
      },
    ];

    // Convert the data
    final assessments = AssessmentDataConverter.convertLegacyData(mockData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Card Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Testing Assessment Card with Mock Data',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.foregroundDark 
                    : AppColors.foreground,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Mock data items: ${mockData.length}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Converted assessments: ${assessments.length}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Statuses: ${assessments.map((a) => a.status).join(', ')}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            
            // The actual assessment card
            AssessmentCard(
              assessments: assessments,
              title: 'Test Assessment Card',
              subtitle: 'Verifying mock data retrieval',
              onAssessmentTap: (assessment) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tapped: ${assessment.title} (${assessment.status})'),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Raw data display
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Raw Assessment Data:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ...assessments.map((assessment) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${assessment.courseId} - ${assessment.title} (${assessment.status}) - Score: ${assessment.earnedPoints ?? 'N/A'}/${assessment.totalPoints}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    )),
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
