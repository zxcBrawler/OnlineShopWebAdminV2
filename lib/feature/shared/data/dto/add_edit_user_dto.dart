class UserDTO {
  int gender = 0;
  String email = "";
  String phoneNumber = "";
  String username = "";
  String passwordHash = "";
  int role = 0;
  String employeeNumber = "";

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'passwordHash': passwordHash,
      'phoneNumber': phoneNumber,
      'username': username,
      'employeeNumber': employeeNumber,
      'role': role,
      'gender': gender,
    };
  }
}
