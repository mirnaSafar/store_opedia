import 'package:flutter/material.dart';

class CreatePhoneNumberFormField extends StatelessWidget {
  final Function setPhoneNumber;

  const CreatePhoneNumberFormField({Key? key, required this.setPhoneNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 10,
        initialValue: "09",
        //controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Enter your phone number',
          labelStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(
            Icons.phone,
            color: Theme.of(context).colorScheme.primary,
          ),
          helperText: 'Phone number must start with 09',
          helperStyle: const TextStyle(fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        validator: (String? value) {
          if (value!.isEmpty ||
              value.length < 10 ||
              value.substring(0, 2) != '09') {
            return 'Please Enter a valid phone Number';
          }
          return null;
        },
        onSaved: (String? value) {
          setPhoneNumber(value);
        });
  }
}
