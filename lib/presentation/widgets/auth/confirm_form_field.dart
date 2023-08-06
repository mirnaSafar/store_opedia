import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';

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
            filled: true,
            fillColor: const Color.fromRGBO(242, 242, 242, 1),
            labelText: '   Confirm Password',
            labelStyle: TextStyle(fontSize: 20, color: AppColors.mainTextColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            suffixIcon: widget.isConfiermPasswordHidden
                ? IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                      color: AppColors.mainTextColor,
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
            return 'Passwords don\'t match';
          }
          return null;
        });
  }
}
