class UserDTO {
  int id = 0;
  int gender = 0;
  String email = "";
  String phoneNumber = "";
  String username = "";
  String passwordHash = "";
  int role = 0;
  String employeeNumber = "";
  int shopAddressId = 0;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'passwordHash': passwordHash,
      'phoneNumber': phoneNumber,
      'username': username,
      'employeeNumber': employeeNumber,
      'role': role,
      'gender': gender,
      'shopAddressId': shopAddressId
    };
  }
}
