class User {
  final int id;
  final String email;
  final String? uid;
  final String role;
  final String displayName;
  final int? teacherId;
  final int? studentId;
  final int? parentId;

  User({
    required this.id,
    required this.email,
    this.uid,
    required this.role,
    required this.displayName,
    this.teacherId,
    this.studentId,
    this.parentId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String? ?? '',
      uid: json['uid'] as String?,
      role: json['role'] as String? ?? 'student',
      displayName: json['display_name'] as String? ?? 'User',
      teacherId: json['teacher_id'] as int?,
      studentId: json['student_id'] as int?,
      parentId: json['parent_id'] as int?,
    );
  }

  bool get isAdmin => role == 'admin';
  bool get isTeacher => role == 'teacher';
  bool get isStudent => role == 'student';
  bool get isParent => role == 'parent';
}
