/// Roles available in the application.
enum UserRole {
  /// A client looking for salon services.
  client,

  /// A salon owner managing their business.
  owner;

  /// Creates a [UserRole] from a JSON string.
  static UserRole fromJson(String value) {
    return UserRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserRole.client,
    );
  }

  /// Converts this role to a JSON string.
  String toJson() => name;
}
