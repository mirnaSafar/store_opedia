import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreatePasswordFormField extends StatefulWidget {
  CreatePasswordFormField(
      {Key? key, required this.setPassword, required this.isPasswordHidden})
      : super(key: key);
  final Function setPassword;
  late bool isPasswordHidden;

  @override
  State<CreatePasswordFormField> createState() =>
      _CreatePasswordFormFieldState();
}

class _CreatePasswordFormFieldState extends State<CreatePasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
              fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
          prefixIcon: Icon(
            Icons.lock,
            color: Theme.of(context).colorScheme.primary,
          ),
          helperText: 'Password must +5 chars and Less Than 15',
          helperStyle: const TextStyle(fontSize: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2, color: Theme.of(context).colorScheme.primary),
          ),
          suffixIcon: widget.isPasswordHidden
              ? IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.isPasswordHidden = !widget.isPasswordHidden;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.visibility,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.isPasswordHidden = !widget.isPasswordHidden;
                    });
                  },
                )),
      obscureText: widget.isPasswordHidden,
      validator: (String? value) {
        if (value!.isEmpty || value.length < 5 || value.length > 14) {
          return 'Password  must be +5 chars and less than 15';
        }
      },
      onChanged: (String value) {
        widget.setPassword(value);
      },
      onSaved: (String? value) {
        widget.setPassword(value);
      },
    );
  }
}
