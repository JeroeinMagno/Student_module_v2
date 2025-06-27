import '../models/student_info_models.dart';
import '../datasources/datasources.dart';
import 'base_repository.dart';

/// Student repository interface
abstract class StudentRepository {
  /// Get student profile information
  Future<RepositoryResult<StudentInfo>> getStudentProfile();
  
  /// Get student program information
  Future<RepositoryResult<ProgramInfo>> getStudentProgram();
  
  /// Get student enrollment history
  Future<RepositoryResult<List<Map<String, dynamic>>>> getEnrollmentHistory();
  
  /// Update student profile
  Future<RepositoryResult<StudentInfo>> updateStudentProfile(Map<String, dynamic> data);
}

/// Student repository implementation
class StudentRepositoryImpl implements StudentRepository {
  final StudentDataSource _studentDataSource;
  
  StudentRepositoryImpl(this._studentDataSource);
  
  @override
  Future<RepositoryResult<StudentInfo>> getStudentProfile() async {
    try {
      final studentInfo = await _studentDataSource.getStudentProfile();
      return RepositoryResult.success(studentInfo);
    } catch (e) {
      return RepositoryResult.failure('Failed to get student profile: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<ProgramInfo>> getStudentProgram() async {
    try {
      final programInfo = await _studentDataSource.getStudentProgram();
      return RepositoryResult.success(programInfo);
    } catch (e) {
      return RepositoryResult.failure('Failed to get program information: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<List<Map<String, dynamic>>>> getEnrollmentHistory() async {
    try {
      final history = await _studentDataSource.getEnrollmentHistory();
      return RepositoryResult.success(history);
    } catch (e) {
      return RepositoryResult.failure('Failed to get enrollment history: ${e.toString()}');
    }
  }
  
  @override
  Future<RepositoryResult<StudentInfo>> updateStudentProfile(Map<String, dynamic> data) async {
    try {
      final updatedProfile = await _studentDataSource.updateStudentProfile(data);
      return RepositoryResult.success(updatedProfile);
    } catch (e) {
      return RepositoryResult.failure('Failed to update student profile: ${e.toString()}');
    }
  }
}
