import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateConfirmPasswordFormField extends StatefulWidget {
  CreateConfirmPasswordFormField(
      {Key? key,
      required this.getPassword,
      required this.isConfiermPasswordHidden})
      : super(key: key);
  final Function getPassword;
  late bool isConfiermPasswordHidden;

  @override
  State<CreateConfirmPasswordFormField> createState() =>
      _CreateConfirmPasswordFormFieldState();
}

class _CreateConfirmPasswordFormFieldState
    extends State<CreateConfirmPasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Confirm Password',
            labelStyle: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
            prefixIcon: Icon(
              Icons.password,
              color: Theme.of(context).colorScheme.primary,
            ),
            helperText: 'Password must be More Than 8',
            helperStyle: const TextStyle(fontSize: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Theme.of(context).colorScheme.primary),
            ),
            suffixIcon: widget.isConfiermPasswordHidden
                ? IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.isConfiermPasswordHidden =
                            !widget.isConfiermPasswordHidden;
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
                        widget.isConfiermPasswordHidden =
                            !widget.isConfiermPasswordHidden;
                      });
                    },
                  )),
        obscureText: widget.isConfiermPasswordHidden,
        validator: (String? value) {
          // ignore: unrelated_type_equality_checks
          if (value != widget.getPassword() || value!.isEmpty) {
            return 'Passwords dont match';
          }
          return null;
        });
  }
}
