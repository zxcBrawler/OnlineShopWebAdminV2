class LoginDTO {
  String? username;
  String? passwordHash;
  String? accessToken;

  LoginDTO({required this.username, required this.passwordHash});
}
