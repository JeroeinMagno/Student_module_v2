# Centralized Mock Data System

This document describes the centralized mock data system implemented for the Student Module. The system separates mock data from UI components and provides a single source of truth for all student-related data.

## Overview

The centralized data system consists of:

1. **CentralizedMockData** - Contains all mock data for a single test user
2. **CentralizedDataService** - Provides data access methods with API readiness
3. **Test Suite** - Comprehensive tests to ensure data integrity
4. **Updated Repository** - Uses centralized service instead of scattered data

## Files Structure

```
lib/src/data/
├── mock/
│   ├── centralized_mock_data.dart      # All mock data for test user
│   └── mock_data_service.dart          # Legacy (can be removed later)
├── services/
│   └── centralized_data_service.dart   # Data access service
├── repositories/
│   └── mock_student_repository_impl.dart # Updated to use centralized service
└── ...

test/data/services/
└── centralized_data_service_test.dart   # Comprehensive test suite

lib/src/presentation/widgets/demo/
└── centralized_data_demo.dart           # Demo widget showing usage
```

## Key Features

### 1. Single Test User Data
- All data belongs to one consistent test user (`test_user_001`)
- Complete profile: John Doe, SR Code: 22-12345
- 6 enrolled courses with realistic data
- Assessment history with grades and scores
- Performance analytics and trends

### 2. API-Ready Architecture
- Easy switching between mock and API data
- Placeholder methods for future API integration
- Data validation methods
- Network delay simulation for realistic testing

### 3. Data Integrity
- Consistent relationships between courses, assessments, and user data
- Comprehensive validation methods
- Type-safe data access
- Error handling for missing data

### 4. Comprehensive Testing
- 50+ test cases covering all data scenarios
- Configuration testing
- Data validation testing
- Consistency checks across different data sources

## Test User Data Structure

### Student Information
```dart
{
  'id': 'test_user_001',
  'name': 'John Doe',
  'srCode': '22-12345',
  'email': 'john.doe@student.bsu.edu.ph',
  'yearLevel': '3rd Year',
  'program': 'Bachelor of Science in Computer Science',
  'college': 'College of Engineering and Information Technology',
  'semester': '2nd Semester',
  'academicYear': '2024-2025',
  'gpa': 3.75,
  'units': 21,
  'status': 'Regular',
}
```

### Enrolled Courses (6 courses)
1. **CS 101** - Introduction to Computer Science (Prof. Jane Doe)
2. **MATH 201** - Discrete Mathematics (Dr. John Smith)
3. **IT 310** - Web Development (Engr. Lance Ramos)
4. **PHY 201** - Physics II (Dr. Maria Garcia)
5. **ENG 101** - Technical Writing (Prof. Sarah Johnson)
6. **HIST 101** - Philippine History (Dr. Ramon Santos)

Each course includes:
- Complete course information (code, title, description, instructor)
- Schedule and room information
- Progress tracking (45% to 90%)
- Current grades (A to B+)
- Exam schedules with status (completed/upcoming/missing)

### Assessment Data
- 5 recent assessments with detailed information
- Grades ranging from B to A
- Various assessment types (Exams, Projects, Essays, Lab Work)
- Linked to specific courses
- Date tracking

### Performance Analytics
- Grade distribution: Excellent (40%), Good (30%), Average (20%), Poor (10%)
- 6-month GPA trends showing improvement (3.2 to 3.9)
- Monthly performance scores
- Learning outcomes tracking
- Assessment criteria progress

## Usage Examples

### Basic Data Access
```dart
final dataService = CentralizedDataService();

// Get student information
final studentInfo = await dataService.getStudentInfo();
print('Student: ${studentInfo['name']}');

// Get all courses
final courses = await dataService.getCourses();
print('Enrolled in ${courses.length} courses');

// Get specific course
final course = await dataService.getCourseById('cs101');
print('Course: ${course['title']}');
```

### Configuration Management
```dart
final dataService = CentralizedDataService();

// Check current configuration
print('Using API: ${dataService.isUsingApiData}');
print('Test User: ${dataService.isUsingTestUser}');

// Switch to API mode (when backend is ready)
dataService.enableApiData();

// Switch back to mock data
dataService.enableMockData();

// Print configuration details
dataService.printCurrentConfiguration();
```

### Data Validation
```dart
final dataService = CentralizedDataService();

// Validate student data
final studentData = await dataService.getStudentInfo();
final isValid = dataService.validateStudentData(studentData);
print('Student data valid: $isValid');

// Validate course data
final courses = await dataService.getCourses();
for (var course in courses) {
  final isValidCourse = dataService.validateCourseData(course);
  print('${course['code']} valid: $isValidCourse');
}
```

## Testing

The system includes comprehensive tests covering:

### Configuration Tests
- Default configuration validation
- API/Mock data switching
- Test user configuration

### Data Retrieval Tests
- Student information retrieval
- Course data access
- Assessment data fetching
- Performance analytics

### Data Validation Tests
- Student data validation
- Course data validation
- Assessment data validation

### Consistency Tests
- Cross-reference validation between courses and assessments
- Data integrity checks
- Configuration state management

### Run Tests
```bash
flutter test test/data/services/centralized_data_service_test.dart
```

## Benefits

### For Development
1. **Single Source of Truth** - All test data in one place
2. **Easy Maintenance** - Update data in one location
3. **Consistent Testing** - Same data across all tests
4. **Type Safety** - Validated data structures

### For Testing
1. **Comprehensive Coverage** - All data scenarios tested
2. **Realistic Data** - Complete user profile with relationships
3. **Easy Debugging** - Clear data structure and validation
4. **Automated Validation** - Built-in data integrity checks

### For API Integration
1. **Ready for Backend** - Easy switch to API calls
2. **Validation Ready** - Data validation methods prepared
3. **Error Handling** - Proper error management structure
4. **Network Simulation** - Realistic delay simulation

## Migration Guide

### From Old MockDataService
The old `MockDataService` is still available but deprecated. To migrate:

1. Replace `MockDataService.getStudentInfo()` with `CentralizedDataService().getStudentInfo()`
2. Update repository implementations to use `CentralizedDataService`
3. Use the new validation methods for data integrity
4. Run tests to ensure compatibility

### Preparing for API Integration
When the backend API is ready:

1. Create API service classes
2. Update `CentralizedDataService` to use API calls instead of mock data
3. Enable API mode: `dataService.enableApiData()`
4. Update error handling for network failures
5. Maintain data validation for API responses

## Demo

A demo widget (`CentralizedDataDemo`) is available that shows:
- Current configuration status
- Data switching capabilities
- Real-time data loading
- Error handling demonstration
- All user data display

## Future Enhancements

1. **Multiple Test Users** - Support for different user profiles
2. **Data Caching** - Cache API responses for better performance
3. **Offline Support** - Fallback to cached data when offline
4. **Data Synchronization** - Sync local changes with backend
5. **Real-time Updates** - WebSocket support for live data updates

## Conclusion

The centralized mock data system provides a robust foundation for the Student Module with:
- Clean separation of data and UI
- Complete test coverage
- API readiness
- Easy maintenance and updates
- Realistic test scenarios

This system ensures that when the backend API is ready, the transition will be smooth and the data integrity will be maintained throughout the application.
