import 'package:flutter/material.dart';

class ProfilePasswordFormField extends StatefulWidget {
  const ProfilePasswordFormField({Key? key, required this.password})
      : super(key: key);
  final String password;

  @override
  State<ProfilePasswordFormField> createState() =>
      _ProfilePasswordFormFieldState();
}

class _ProfilePasswordFormFieldState extends State<ProfilePasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: widget.password,
        obscureText: true,
        enabled: false,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(
            Icons.lock,
            color: Theme.of(context).colorScheme.primary,
          ),
          helperStyle: const TextStyle(fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.primary),
          ),
        ));
  }
}
