class UserProfile {
  final String id;
  final String email;
  final String fullName;
  final bool emailVerified;

  UserProfile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.emailVerified,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      emailVerified: json['emailVerified'],
    );
  }
}
