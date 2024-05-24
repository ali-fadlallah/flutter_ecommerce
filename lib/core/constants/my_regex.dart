class CustomRegex {
  static bool? isValidEmail(String? email) {
    if (email == null) return false;
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static bool? isPassword(String? password) {
    if (password == null) return false;
    return RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$").hasMatch(password);
  }

  static bool? isMobile(String? mobile) {
    if (mobile == null) return false;
    return RegExp(r"^01[0125][0-9]{8}$").hasMatch(mobile);
  }
}
