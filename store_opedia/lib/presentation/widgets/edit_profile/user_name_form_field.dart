import 'package:flutter/material.dart';

class EditUserNameFormField extends StatelessWidget {
  const EditUserNameFormField(
      {Key? key, required this.setUserName, required this.userName})
      : super(key: key);
  final Function setUserName;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: userName,
        readOnly: false,
        decoration: InputDecoration(
          labelText: 'User Name',
          labelStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
          ),
          helperText: 'Name must be +3 characters',
          helperStyle: const TextStyle(fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        validator: (String? value) {
          if (value!.isEmpty || value.length < 3 || value.length > 15) {
            return 'Please Enter a valid Name';
          }
          return null;
        },
        onChanged: (String? value) {
          setUserName(value);
        },
        onSaved: (String? value) {
          setUserName(value!);
        });
  }
}
