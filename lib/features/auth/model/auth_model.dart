/// Authentication related models for the student module

/// Represents user authentication state
enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

/// User model for authenticated users
class User {
  final String id;
  final String email;
  final String? name;
  final String? studentId;
  final DateTime? lastLogin;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.studentId,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      studentId: json['studentId'] as String?,
      lastLogin: json['lastLogin'] != null 
        ? DateTime.parse(json['lastLogin'] as String)
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'studentId': studentId,
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? studentId,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      studentId: studentId ?? this.studentId,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User{id: $id, email: $email, name: $name, studentId: $studentId}';
  }
}

/// Login request model
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'LoginRequest{email: $email}'; // Don't log password
  }
}

/// Authentication response model
class AuthResponse {
  final User user;
  final String? token;
  final DateTime? expiresAt;

  const AuthResponse({
    required this.user,
    this.token,
    this.expiresAt,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      expiresAt: json['expiresAt'] != null 
        ? DateTime.parse(json['expiresAt'] as String)
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }
}
