/// Mock data for student information
class MockStudentData {
  static Map<String, dynamic> get studentInfo => {
    'id': 'STU-2024-001',
    'name': 'Juan Dela Cruz',
    'email': 'juan.delacruz@bsu.edu.ph',
    'studentNumber': '2021-123456',
    'program': 'Bachelor of Science in Computer Science',
    'yearLevel': 3,
    'semester': 'Midyear',
    'academicYear': '2024-2025',
    'units': 21,
    'gwa': 1.75,
    'status': 'Regular',
    'avatar': null,
  };

  static Map<String, dynamic> get programInfo => {
    'name': 'Bachelor of Science in Computer Science',
    'code': 'BSCS',
    'college': 'College of Engineering',
    'totalUnits': 168,
    'completedUnits': 126,
    'remainingUnits': 42,
    'expectedGraduation': '2025-04-30',
  };

  static List<Map<String, dynamic>> get enrollmentHistory => [
    {
      'academicYear': '2024-2025',
      'semester': 'Midyear',
      'units': 21,
      'gwa': 1.75,
      'status': 'Enrolled',
    },
    {
      'academicYear': '2023-2024',
      'semester': '2nd Semester',
      'units': 24,
      'gwa': 1.80,
      'status': 'Completed',
    },
    {
      'academicYear': '2023-2024',
      'semester': '1st Semester',
      'units': 21,
      'gwa': 1.85,
      'status': 'Completed',
    },
  ];
}
