import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/colors.dart';

class CreateSMSFormField extends StatelessWidget {
  const CreateSMSFormField({Key? key, required this.setSMS}) : super(key: key);
  final Function setSMS;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(242, 242, 242, 1),
        labelText: '   SMS',
        labelStyle: TextStyle(
          color: AppColors.mainTextColor,
          fontSize: 20,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
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
