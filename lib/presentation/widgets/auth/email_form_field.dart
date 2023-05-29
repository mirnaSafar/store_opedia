import 'package:flutter/material.dart';

class CreateEmailFormField extends StatelessWidget {
  const CreateEmailFormField({Key? key, required this.setEmail})
      : super(key: key);
  final Function setEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(
          Icons.email,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20,
        ),
        helperText: 'example of Email: exampel@gmail.com  ',
        helperStyle: const TextStyle(fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.primary),
        ),
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
