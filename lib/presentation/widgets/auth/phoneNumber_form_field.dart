import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/utils.dart';

class CreatePhoneNumberFormField extends StatelessWidget {
  final Function setPhoneNumber;

  const CreatePhoneNumberFormField({Key? key, required this.setPhoneNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 10,
        initialValue: "09",
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(242, 242, 242, 1),
          labelText: 'Enter your phone number',
          labelStyle: TextStyle(fontSize: 20, color: AppColors.mainTextColor),
          prefixIcon: Icon(
            Icons.phone,
            color: AppColors.mainTextColor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
        ),
        validator: (String? value) {
          if (value!.isEmpty || !isMobileNumber(value)) {
            return 'Please Enter a valid phone Number';
          }

          // if (
          //     value.length < 10 ||
          //     value.substring(0, 2) != '09') {
          //      }
          return null;
        },
        onSaved: (String? value) {
          setPhoneNumber(value);
        });
  }
}
