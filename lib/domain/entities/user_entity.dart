/// User entity (domain layer)
class UserEntity {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final DateTime? createdAt;
  
  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    this.createdAt,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.id == id &&
        other.email == email &&
        other.name == name;
  }
  
  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ name.hashCode;
}

