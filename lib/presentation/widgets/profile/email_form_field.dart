import 'package:flutter/material.dart';

class ProfileEmailFormField extends StatelessWidget {
  const ProfileEmailFormField({Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: email,
      enabled: false,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(
          Icons.mail,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20,
        ),
        helperStyle: const TextStyle(fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
