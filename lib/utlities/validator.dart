/// Validator class for Edit Text Validation
class AppValidator {
  /// validator for required Edit Text

  static String validatorRequired(value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  static String validatorEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    RegExp regExp = new RegExp(pattern);
    if (value.isNotEmpty && !regExp.hasMatch(value)) {
      return 'Email is not valid';
    }
    return null;
  }
}
