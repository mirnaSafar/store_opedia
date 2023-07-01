import 'package:shopesapp/data/enums/file_type.dart';

bool isEmail(String value) {
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(value);
}

bool validPassword(String password) {
  RegExp passExp =
      RegExp(r'^(?=.*[^a-zA-Z\d\s])(?=.*[a-zA-Z])[@$!%*?&a-zA-Z\d]{8,}$');
  return passExp.hasMatch(password);
}

bool isName(String name) {
  RegExp nameExp = RegExp(r'^[a-zA-Z\s]{2,15}$');
  return nameExp.hasMatch(name);
}

bool isMobileNumber(String num) {
  RegExp numExp = RegExp(r'^((\+|00)?(963)|0)?9[0-9]{8}$');
  return numExp.hasMatch(num);
}

class FileTypeModel {
  FileType type;
  String path;

  FileTypeModel(this.path, this.type);
}

    // show the dialog
    