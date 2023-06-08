import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';

class CreateEmailFormField extends StatelessWidget {
  const CreateEmailFormField({Key? key, required this.setEmail})
      : super(key: key);
  final Function setEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(242, 242, 242, 1),
        labelText: '  Email',
        labelStyle: TextStyle(
          color: AppColors.mainTextColor,
          fontSize: 20,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        if (value == null ||
            value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Enter a valid email.';
        }
        return null;
      },
      onSaved: (String? value) {
        setEmail(value);
      },
    );
  }
}
