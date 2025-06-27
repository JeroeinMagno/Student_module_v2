import '../models/student_info_models.dart';
import 'base_datasource.dart';

/// Student data source interface
abstract class StudentDataSource {
  /// Get student profile information
  Future<StudentInfo> getStudentProfile();
  
  /// Get student program information
  Future<ProgramInfo> getStudentProgram();
  
  /// Get student enrollment history
  Future<List<Map<String, dynamic>>> getEnrollmentHistory();
  
  /// Update student profile
  Future<StudentInfo> updateStudentProfile(Map<String, dynamic> data);
}

/// Student API service implementation
class StudentApiService implements StudentDataSource {
  final BaseApiService _apiService;
  
  StudentApiService(this._apiService);
  
  @override
  Future<StudentInfo> getStudentProfile() async {
    final response = await _apiService.get<Map<String, dynamic>>('/student/profile');
    return StudentInfo.fromJson(response);
  }
  
  @override
  Future<ProgramInfo> getStudentProgram() async {
    final response = await _apiService.get<Map<String, dynamic>>('/student/program');
    return ProgramInfo.fromJson(response);
  }
  
  @override
  Future<List<Map<String, dynamic>>> getEnrollmentHistory() async {
    return await _apiService.get<List<Map<String, dynamic>>>('/student/enrollment-history');
  }
  
  @override
  Future<StudentInfo> updateStudentProfile(Map<String, dynamic> data) async {
    final response = await _apiService.put<Map<String, dynamic>>('/student/profile', data: data);
    return StudentInfo.fromJson(response);
  }
}

/// Mock student data source for development
class MockStudentDataSource implements StudentDataSource {
  static const Duration _mockDelay = Duration(milliseconds: 500);
  
  @override
  Future<StudentInfo> getStudentProfile() async {
    await Future.delayed(_mockDelay);
    
    return StudentInfo(
      id: 'student_123',
      name: 'John Doe',
      email: 'john.doe@university.edu',
      studentNumber: '2021-12345',
      program: 'Computer Science',
      yearLevel: 3,
      semester: '1st Semester',
      academicYear: '2024-2025',
      units: 21,
      gwa: 1.75,
      status: 'Regular',
    );
  }
  
  @override
  Future<ProgramInfo> getStudentProgram() async {
    await Future.delayed(_mockDelay);
    
    return ProgramInfo(
      name: 'Bachelor of Science in Computer Science',
      code: 'BSCS',
      college: 'College of Engineering',
      totalUnits: 180,
      completedUnits: 120,
      remainingUnits: 60,
      expectedGraduation: '2025-04-30',
    );
  }
  
  @override
  Future<List<Map<String, dynamic>>> getEnrollmentHistory() async {
    await Future.delayed(_mockDelay);
    
    return [
      {
        'semester': '1st Semester',
        'academicYear': '2024-2025',
        'units': 21,
        'gwa': 1.75,
        'status': 'Enrolled',
      },
      {
        'semester': '2nd Semester',
        'academicYear': '2023-2024',
        'units': 24,
        'gwa': 1.50,
        'status': 'Completed',
      },
    ];
  }
  
  @override
  Future<StudentInfo> updateStudentProfile(Map<String, dynamic> data) async {
    await Future.delayed(_mockDelay);
    
    // Return updated profile with new data
    return StudentInfo(
      id: 'student_123',
      name: data['name'] ?? 'John Doe',
      email: data['email'] ?? 'john.doe@university.edu',
      studentNumber: '2021-12345',
      program: 'Computer Science',
      yearLevel: 3,
      semester: '1st Semester',
      academicYear: '2024-2025',
      units: 21,
      gwa: 1.75,
      status: 'Regular',
    );
  }
}
