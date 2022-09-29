class ValidatorUtil {
  static final instance = ValidatorUtil._();

  ValidatorUtil._();

  bool isEmail(String value) {
    const email =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return RegExp(email).hasMatch(value);
  }

  bool isPhone(String value) {
    const phone =
        r"^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$";
    return RegExp(phone).hasMatch(value);
  }

  bool passwordIsValid(String value) {
    const password = r"^(?=.*[0-9])(?=.{6,})";

    return RegExp(password).hasMatch(value);
  }

  bool isLink(String value) {
    const linkValidator = r'^http[s]?:\/\/.+$';
    return RegExp(linkValidator).hasMatch(value);
  }
}
