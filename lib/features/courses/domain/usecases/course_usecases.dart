import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/course_entity.dart';
import '../repositories/course_repository.dart';

/// Use case for getting all courses
class GetCoursesUseCase {
  final CourseRepository _repository;

  const GetCoursesUseCase(this._repository);

  Future<Result<List<CourseEntity>>> call() {
    return _repository.getCourses();
  }
}

/// Use case for getting a course by ID
class GetCourseByIdUseCase {
  final CourseRepository _repository;

  const GetCourseByIdUseCase(this._repository);

  Future<Result<CourseEntity>> call(String courseId) {
    return _repository.getCourseById(courseId);
  }
}

/// Use case for getting enrolled courses
class GetEnrolledCoursesUseCase {
  final CourseRepository _repository;

  const GetEnrolledCoursesUseCase(this._repository);

  Future<Result<List<CourseEntity>>> call() {
    return _repository.getEnrolledCourses();
  }
}

/// Use case for enrolling in a course
class EnrollInCourseUseCase {
  final CourseRepository _repository;

  const EnrollInCourseUseCase(this._repository);

  Future<Result<void>> call(String courseId) {
    return _repository.enrollInCourse(courseId);
  }
}

/// Use case for searching courses
class SearchCoursesUseCase {
  final CourseRepository _repository;

  const SearchCoursesUseCase(this._repository);

  Future<Result<List<CourseEntity>>> call(String query) {
    if (query.trim().isEmpty) {
      return Future.value(const Result.success([]));
    }
    return _repository.searchCourses(query);
  }
}

/// Use case for updating course progress
class UpdateCourseProgressUseCase {
  final CourseRepository _repository;

  const UpdateCourseProgressUseCase(this._repository);

  Future<Result<void>> call(String courseId, double progress) {
    if (progress < 0 || progress > 100) {
      return Future.value(const Result.failure(InvalidInputFailure('Progress must be between 0 and 100')));
    }
    return _repository.updateCourseProgress(courseId, progress);
  }
}

/// Use case for getting recommended courses
class GetRecommendedCoursesUseCase {
  final CourseRepository _repository;

  const GetRecommendedCoursesUseCase(this._repository);

  Future<Result<List<CourseEntity>>> call() {
    return _repository.getRecommendedCourses();
  }
}
