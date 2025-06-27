/// Student information and profile related models

class StudentInfo {
  final String id;
  final String name;
  final String email;
  final String studentNumber;
  final String program;
  final int yearLevel;
  final String semester;
  final String academicYear;
  final int units;
  final double gwa;
  final String status;

  StudentInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.studentNumber,
    required this.program,
    required this.yearLevel,
    required this.semester,
    required this.academicYear,
    required this.units,
    required this.gwa,
    required this.status,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) {
    return StudentInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      studentNumber: json['studentNumber'],
      program: json['program'],
      yearLevel: json['yearLevel'],
      semester: json['semester'],
      academicYear: json['academicYear'],
      units: json['units'],
      gwa: json['gwa'].toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'studentNumber': studentNumber,
      'program': program,
      'yearLevel': yearLevel,
      'semester': semester,
      'academicYear': academicYear,
      'units': units,
      'gwa': gwa,
      'status': status,
    };
  }
}

class ProgramInfo {
  final String name;
  final String code;
  final String college;
  final int totalUnits;
  final int completedUnits;
  final int remainingUnits;
  final String expectedGraduation;

  ProgramInfo({
    required this.name,
    required this.code,
    required this.college,
    required this.totalUnits,
    required this.completedUnits,
    required this.remainingUnits,
    required this.expectedGraduation,
  });

  factory ProgramInfo.fromJson(Map<String, dynamic> json) {
    return ProgramInfo(
      name: json['name'],
      code: json['code'],
      college: json['college'],
      totalUnits: json['totalUnits'],
      completedUnits: json['completedUnits'],
      remainingUnits: json['remainingUnits'],
      expectedGraduation: json['expectedGraduation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'college': college,
      'totalUnits': totalUnits,
      'completedUnits': completedUnits,
      'remainingUnits': remainingUnits,
      'expectedGraduation': expectedGraduation,
    };
  }
}
