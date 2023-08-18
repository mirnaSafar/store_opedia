import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/translation/locale_keys.g.dart';

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
          filled: true,
          //  fillColor: const Color.fromRGBO(242, 242, 242, 1),
          labelText: LocaleKeys.password.tr(),
          labelStyle: TextStyle(fontSize: 16, color: AppColors.mainTextColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          suffixIcon: widget.isPasswordHidden
              ? IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: AppColors.mainTextColor,
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
        // return passValidator(value);
        return null;
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
