class AppValidator {
  AppValidator._();

  static bool validateEmpty(String? input) {
    if (input == null) return false;
    return input.isNotEmpty;
  }

  static bool validateLength(String? input, int min, int max) {
    if (input == null) return false;
    return input.length >= min && input.length <= max;
  }

  static bool validatePassword(String? input) {
    if (input == null) return false;
    RegExp regex = RegExp(r'^[a-zA-Z0-9`!@#$%\^&*()={}:;<>+-]{6,30}$');
    return regex.hasMatch(input);
  }

  static bool validateConfirmPasswordMatch(
      String? password, String? confirmPassword) {
    if (password == null || confirmPassword == null) return false;
    return password == confirmPassword;
  }

  static bool validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) return false;
    return phoneNumber.replaceAll(RegExp(r'[^0-9]'), '').length >= 10;
  }

  static bool validateCodeToVerifyPhoneNumber(String? code) {
    if (code == null) return false;
    return code.replaceAll(RegExp(r'[^0-9]'), '').isNotEmpty;
  }

  static bool validateEmail(String? email) {
    if (email == null) return false;
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool validateFullName(String? name) {
    if (name == null) return false;
    return RegExp(
        r"^[a-zA-Z]+( [a-zA-Z]+)*$")
        .hasMatch(name);
  }

  static bool validateNickname(String? name) {
    if (name == null) return false;
    return RegExp(
        r"^[a-zA-Z0-9_.]+([a-zA-Z0-9_.]+)*$")
        .hasMatch(name);
  }

  static bool validateClub(String? club) {
    if (club == null) return false;
    return RegExp(
        r"^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$")
        .hasMatch(club);
  }
}
