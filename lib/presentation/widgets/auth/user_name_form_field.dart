import 'package:flutter/material.dart';

class CreateUserNameFormField extends StatelessWidget {
  const CreateUserNameFormField({Key? key, required this.setUserName})
      : super(key: key);
  final Function setUserName;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          if (value!.isEmpty || value.length < 4 || value.length > 15) {
            return 'Please Enter a valid Name';
          }
          return null;
        },
        onSaved: (String? value) {
          setUserName(value!);
        });
  }
}
