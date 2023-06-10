import "package:flutter/material.dart";
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shopesapp/data/enums/file_type.dart';

bool isEmail(String value) {
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(value);
}

bool validPassword(String password) {
  RegExp passExp =
      RegExp(r'^(?=.*[^a-zA-Z\d\s])(?=.*[a-zA-Z])[@$!%*?&a-zA-Z\d]{8}$');
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

final storeDialog = RatingDialog(
  initialRating: 1.0,
  title: const Text(''),
  message: const Text(
    'Please Rate the store if you tried it',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 15),
  ),
  submitButtonText: 'Submit',
  commentHint: 'you can leave your comment here',
  onCancelled: () => print('cancelled'),
  onSubmitted: (response) {
    print('rating: ${response.rating}, comment: ${response.comment}');

    if (response.rating < 3.0) {
    } else {
      // _rateAndReviewApp();
    }
  },
);

    // show the dialog
    