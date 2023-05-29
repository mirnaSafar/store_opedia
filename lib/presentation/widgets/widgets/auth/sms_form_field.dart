import 'package:flutter/material.dart';

class CreateSMSFormField extends StatelessWidget {
  const CreateSMSFormField({Key? key, required this.setSMS}) : super(key: key);
  final Function setSMS;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'SMS',
        prefixIcon: Icon(
          Icons.mail_lock,
          color: Theme.of(context).colorScheme.primary,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20,
        ),
        helperText: 'Check your SMS Inbox  ',
        helperStyle: const TextStyle(fontSize: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Enter the Verifiy code';
        }
        return null;
      },
      onSaved: (String? value) {
        setSMS(value);
      },
    );
  }
}
