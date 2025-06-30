import 'package:flutter/material.dart';
import '../../../presentation/widgets/dashboard/assessment_data_converter.dart';

/// Debug page to test assessment data conversion
class AssessmentDataDebugPage extends StatelessWidget {
  const AssessmentDataDebugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        'course': 'CS 302',
        'type': 'Project',
        'score': null,
        'maxScore': 100.0,
        'date': 'Nov 20, 2024',
        'status': 'In Progress',
      },
    ];

    final convertedData = AssessmentDataConverter.convertLegacyData(mockData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Data Debug'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Original Mock Data (${mockData.length} items):',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...mockData.map((item) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Course: ${item['course']}'),
                    Text('Type: ${item['type']}'),
                    Text('Score: ${item['score']}/${item['maxScore']}'),
                    Text('Date: ${item['date']}'),
                    Text('Status: ${item['status']}'),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 16),
            Text(
              'Converted Assessment Data (${convertedData.length} items):',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...convertedData.map((assessment) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${assessment.id}'),
                    Text('Course: ${assessment.courseId}'),
                    Text('Title: ${assessment.title}'),
                    Text('Type: ${assessment.type}'),
                    Text('Score: ${assessment.earnedPoints}/${assessment.totalPoints}'),
                    Text('Due Date: ${assessment.dueDate}'),
                    Text('Status: ${assessment.status}'),
                    Text('Completed: ${assessment.status == 'graded' || assessment.status == 'completed'}'),
                    Text('In Progress: ${assessment.status == 'pending' || assessment.status == 'submitted'}'),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
