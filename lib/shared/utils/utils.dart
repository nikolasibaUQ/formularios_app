class Utils {
  static bool validateEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  //validate a password with at least one letter, one number, and one special character
  static bool validatePassword(String password) {
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  //validate date format
  static bool validateDate(String date) {
    String pattern =
        r'^(0[1-9]|1[0-9]|2[0-9]|3[0-1])/(0[1-9]|1[0-2])/[0-9]{4}$';
    String pattern2 =
        r'^(0[1-9]|1[0-9]|2[0-9]|3[0-1])-(0[1-9]|1[0-2])-[0-9]{4}$';
    RegExp regExp = RegExp(pattern);
    RegExp regExp2 = RegExp(pattern2);

    return regExp.hasMatch(date) || regExp2.hasMatch(date);
  }

  //static method to validate no numbers in a string
  static bool validateNoNumbers(String text) {
    String pattern = r'^[a-zA-Z\s]*$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }
}
