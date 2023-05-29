import 'package:flutter/material.dart';

class ProfilePhoneNumberFormField extends StatelessWidget {
  final String phoneNmber;

  const ProfilePhoneNumberFormField({Key? key, required this.phoneNmber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 10,
      initialValue: phoneNmber,
      enabled: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: ' Phone number',
        labelStyle: TextStyle(
            fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
        prefixIcon: Icon(
          Icons.phone,
          color: Theme.of(context).colorScheme.primary,
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
