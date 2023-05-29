import 'package:shopesapp/presentation/shared/utils.dart';

confirmPassword(value, password) {
  if (value!.isNotEmpty) {
    if (!validPassword(value)) return 'invalid password';
    return password != value ? 'not match' : null;
  } else {
    return 'enter your password';
  }
}

String? passValidator(value) {
  if (value!.isNotEmpty) {
    if (!validPassword(value)) {
      return 'invalid password';
    }
    return null;
  } else {
    return 'enter your password';
  }
}

String? numberValidator(value) {
  if (value!.isNotEmpty) {
    if (!isMobileNumber(value)) {
      return 'invalid number';
    }
    return null;
  } else {
    return 'enter your number';
  }
}

emailValidator(String? value) {
  if (value!.isNotEmpty) {
    if (!isEmail(value)) {
      return 'invalid email';
    }
    return null;
  } else {
    return 'enter your email';
  }
}

nameValidator(String? value) {
  if (value!.isNotEmpty) {
    if (!isName(value)) {
      return 'invalid name';
    }
    return null;
  } else {
    return 'enter your name';
  }
}
