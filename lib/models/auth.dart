class User {
  final String username;
  final bool isActive;

  User({required this.username, this.isActive = true});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'is_active': isActive};
  }

  @override
  String toString() {
    return 'User(username: $username, isActive: $isActive)';
  }
}
