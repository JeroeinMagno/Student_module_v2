import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_student_module_v2/src/data/services/centralized_data_service.dart';
import 'package:mobile_app_student_module_v2/src/data/mock/centralized_mock_data.dart';
import 'package:mobile_app_student_module_v2/src/data/converters/assessment_converter.dart';

void main() {
  group('Centralized Data Service Tests', () {
    late CentralizedDataService dataService;

    setUp(() {
      dataService = CentralizedDataService();
      dataService.resetConfiguration(); // Ensure clean state
    });

    group('Configuration Tests', () {
      test('should initialize with correct default configuration', () {
        expect(dataService.isUsingApiData, false);
        expect(dataService.isUsingTestUser, true);
        expect(dataService.currentUserId, CentralizedMockData.testUserId);
      });

      test('should switch to API data when enabled', () {
        dataService.enableApiData();
        expect(dataService.isUsingApiData, true);
      });

      test('should switch back to mock data when disabled', () {
        dataService.enableApiData();
        dataService.enableMockData();
        expect(dataService.isUsingApiData, false);
      });

      test('should handle test user configuration', () {
        dataService.disableTestUser();
        expect(dataService.isUsingTestUser, false);
        expect(dataService.currentUserId, 'current_user');
        
        dataService.enableTestUser();
        expect(dataService.isUsingTestUser, true);
        expect(dataService.currentUserId, CentralizedMockData.testUserId);
      });
    });

    group('Student Data Tests', () {
      test('should return valid student info', () async {
        final studentInfo = await dataService.getStudentInfo();
        
        expect(dataService.validateStudentData(studentInfo), true);
        expect(studentInfo['id'], CentralizedMockData.testUserId);
        expect(studentInfo['name'], 'John Doe');
        expect(studentInfo['srCode'], '22-12345');
        expect(studentInfo['email'], 'john.doe@student.bsu.edu.ph');
      });

      test('should return user courses', () async {
        final courses = await dataService.getCourses();
        
        expect(courses, isNotEmpty);
        expect(courses.length, 6);
        
        for (var course in courses) {
          expect(dataService.validateCourseData(course), true);
        }
      });

      test('should return specific course by ID', () async {
        final course = await dataService.getCourseById('cs101');
        
        expect(course, isNotNull);
        expect(course!['id'], 'cs101');
        expect(course['code'], 'CS 101');
        expect(course['title'], 'Introduction to Computer Science');
      });

      test('should return null for non-existent course', () async {
        final course = await dataService.getCourseById('non_existent');
        expect(course, isNull);
      });
    });

    group('Assessment Data Tests', () {
      test('should return recent assessments', () async {
        final assessments = await dataService.getRecentAssessments();
        
        expect(assessments, isNotEmpty);
        expect(assessments.length, 5);
        
        for (var assessment in assessments) {
          expect(dataService.validateAssessmentData(assessment), true);
        }
      });

      test('should return assessments for specific course', () async {
        final assessments = await dataService.getAssessmentsByCourse('cs101');
        
        expect(assessments, isNotEmpty);
        for (var assessment in assessments) {
          expect(assessment['courseId'], 'cs101');
        }
      });

      test('should return all exams', () async {
        final exams = await dataService.getAllExams();
        
        expect(exams, isNotEmpty);
        expect(exams.length, 12); // 6 courses × 2 exams each
        
        for (var exam in exams) {
          expect(exam['courseId'], isNotNull);
          expect(exam['courseCode'], isNotNull);
          expect(exam['title'], isNotNull);
          expect(exam['date'], isNotNull);
          expect(exam['status'], isNotNull);
        }
      });
    });

    group('Performance Analytics Tests', () {
      test('should return performance distribution', () async {
        final distribution = await dataService.getPerformanceDistribution();
        
        expect(distribution, isNotEmpty);
        expect(distribution.keys, containsAll(['excellent', 'good', 'average', 'poor']));
        expect(distribution.values.every((value) => value >= 0 && value <= 100), true);
        
        // Check that percentages add up to 100
        final total = distribution.values.reduce((a, b) => a + b);
        expect(total, 100.0);
      });

      test('should return grade trends', () async {
        final trends = await dataService.getGradeTrends();
        
        expect(trends, isNotEmpty);
        expect(trends.length, 6); // 6 months
        
        for (var trend in trends) {
          expect(trend['month'], isNotNull);
          expect(trend['gpa'], isNotNull);
          expect(trend['gpa'] is num, true);
        }
      });

      test('should return chart data', () async {
        final chartData = await dataService.getChartData();
        
        expect(chartData, isNotEmpty);
        expect(chartData.length, 6); // 6 months
        
        for (var data in chartData) {
          expect(data['month'], isNotNull);
          expect(data['desktop'], isNotNull);
          expect(data['desktop'] is num, true);
        }
      });
    });

    group('Learning Outcomes Tests', () {
      test('should return course topics', () async {
        final topics = await dataService.getCourseTopics();
        
        expect(topics, isNotEmpty);
        expect(topics.length, 6);
        
        for (var topic in topics) {
          expect(topic['week'], isNotNull);
          expect(topic['topic'], isNotNull);
          expect(topic['ilo'], isNotNull);
          expect(topic['so'], isNotNull);
          expect(topic['status'], isNotNull);
        }
      });

      test('should return learning outcomes', () async {
        final outcomes = await dataService.getLearningOutcomes();
        
        expect(outcomes, isNotEmpty);
        expect(outcomes.length, 5);
        
        for (var outcome in outcomes) {
          expect(outcome['ilo'], isNotNull);
          expect(outcome['description'], isNotNull);
          expect(outcome['achieved'], isNotNull);
          expect(outcome['achieved'] is bool, true);
        }
      });

      test('should return assessment criteria', () async {
        final criteria = await dataService.getAssessmentCriteria();
        
        expect(criteria, isNotEmpty);
        expect(criteria.length, 6);
        
        for (var criterion in criteria) {
          expect(criterion['name'], isNotNull);
          expect(criterion['accomplished'], isNotNull);
          expect(criterion['accomplished'] is bool, true);
        }
      });
    });

    group('Career Guidance Tests', () {
      test('should return career paths', () async {
        final careers = await dataService.getCareerPaths();
        
        expect(careers, isNotEmpty);
        expect(careers.length, 6);
        
        for (var career in careers) {
          expect(career['title'], isNotNull);
          expect(career['description'], isNotNull);
          expect(career['skills'], isNotNull);
          expect(career['averageSalary'], isNotNull);
          expect(career['growthRate'], isNotNull);
          expect(career['matchPercentage'], isNotNull);
        }
      });
    });

    group('Utility Tests', () {
      test('should return all user data', () async {
        final allData = await dataService.getAllUserData();
        
        expect(allData, isNotEmpty);
        expect(allData.keys, containsAll([
          'userInfo',
          'courses',
          'assessments',
          'performance',
          'topics',
          'learningOutcomes',
          'assessmentCriteria',
          'careerPaths'
        ]));
      });

      test('should validate student data correctly', () {
        final validData = {
          'id': 'test_id',
          'name': 'Test Name',
          'srCode': 'test_code',
          'email': 'test@email.com'
        };
        expect(dataService.validateStudentData(validData), true);

        final invalidData = {
          'id': 'test_id',
          'name': 'Test Name',
          // Missing srCode and email
        };
        expect(dataService.validateStudentData(invalidData), false);
      });

      test('should validate course data correctly', () {
        final validData = {
          'id': 'test_id',
          'code': 'TEST 101',
          'title': 'Test Course',
          'instructor': 'Test Instructor'
        };
        expect(dataService.validateCourseData(validData), true);

        final invalidData = {
          'id': 'test_id',
          'code': 'TEST 101',
          // Missing title and instructor
        };
        expect(dataService.validateCourseData(invalidData), false);
      });

      test('should validate assessment data correctly', () {
        final validData = {
          'id': 'test_id',
          'courseId': 'course_id',
          'type': 'Exam',
          'date': '2025-01-01',
          'status': 'completed'
        };
        expect(dataService.validateAssessmentData(validData), true);

        final invalidData = {
          'id': 'test_id',
          'courseId': 'course_id',
          // Missing type, date, and status
        };
        expect(dataService.validateAssessmentData(invalidData), false);
      });
    });

    group('Data Consistency Tests', () {
      test('should have consistent data across different methods', () async {
        final studentInfo = await dataService.getStudentInfo();
        final courses = await dataService.getCourses();
        final assessments = await dataService.getRecentAssessments();
        
        // Check that all courses in assessments exist in courses list
        final courseIds = courses.map((c) => c['id']).toSet();
        final assessmentCourseIds = assessments.map((a) => a['courseId']).toSet();
        
        expect(assessmentCourseIds.every((id) => courseIds.contains(id)), true);
        
        // Check that student ID is consistent
        expect(studentInfo['id'], CentralizedMockData.testUserId);
      });

      test('should maintain data integrity when switching configurations', () async {
        // Test with default configuration
        final data1 = await dataService.getStudentInfo();
        
        // Switch configurations and switch back
        dataService.enableApiData();
        dataService.enableMockData();
        dataService.disableTestUser();
        dataService.enableTestUser();
        
        final data2 = await dataService.getStudentInfo();
        
        // Data should be the same
        expect(data1, equals(data2));
      });
    });

    group('Assessment Converter Tests', () {
      test('should convert assessment data to UI models', () {
        final mockData = [
          {
            'courseCode': 'CS101',
            'type': 'Midterm',
            'date': '2025-06-15',
            'status': 'completed',
            'numericScore': 95.0,
          },
          {
            'courseCode': 'MATH201',
            'type': 'Final',
            'date': '2025-08-20',
            'status': 'upcoming',
            'numericScore': null,
          },
        ];

        final uiAssessments = AssessmentConverter.toUIAssessmentList(mockData);
        
        expect(uiAssessments.length, equals(2));
        expect(uiAssessments[0].courseCode, equals('CS101'));
        expect(uiAssessments[0].score, equals(95.0));
        expect(uiAssessments[1].courseCode, equals('MATH201'));
        expect(uiAssessments[1].score, isNull);
      });

      test('should get assessment summary statistics', () {
        final mockAssessments = [
          {'status': 'completed', 'numericScore': 95.0},
          {'status': 'completed', 'numericScore': 88.0},
          {'status': 'upcoming', 'numericScore': null},
          {'status': 'missing', 'numericScore': null},
        ];

        final summary = AssessmentConverter.getAssessmentSummary(mockAssessments);
        
        expect(summary['total'], equals(4));
        expect(summary['completed'], equals(2));
        expect(summary['upcoming'], equals(1));
        expect(summary['missing'], equals(1));
        expect(summary['averageScore'], equals(91.5)); // (95 + 88) / 2
        expect(summary['completionRate'], equals(50)); // 2/4 * 100
      });
    });
  });
}
