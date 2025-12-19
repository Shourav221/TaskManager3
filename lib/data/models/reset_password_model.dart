class ResetPasswordModel {
  late String email;
  late int otp;
  late String password;

  ResetPasswordModel.fromJson(Map<String, dynamic> jsonData) {
    email = jsonData['email'];
    otp = jsonData['otp'];
    password = jsonData['password'];
  }
}
