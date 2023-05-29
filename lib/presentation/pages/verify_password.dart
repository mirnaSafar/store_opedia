import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/models/user.dart';
import '../../logic/cubites/cubit/profile_cubit.dart';

class VerifyPassword extends StatefulWidget {
  const VerifyPassword({Key? key}) : super(key: key);

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  late String _oldPassword;
  late User _user;
  @override
  void initState() {
    super.initState();
    // online
    /* _user = context.read<UserAuthCubit>().getUser();
    _oldPassword = _user.password;*/
    //offline
    _oldPassword = "123456789";
  }

  @override
  Widget build(BuildContext context) {
    double pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/verified.png'),
          SizedBox(
            height: pageHeight / 12,
          ),
          const Center(
            child: Text("Verify Your Password Please"),
          ),
          const SizedBox(
            height: 10.0,
          ),
          PinCodeTextField(
            scrollPadding: const EdgeInsets.all(20),
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                activeColor: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
                selectedColor: Theme.of(context).colorScheme.secondary,
                fieldWidth: _oldPassword.length <= 10 ? 40.0 : 22.0,
                fieldHeight: _oldPassword.length <= 10 ? 50.0 : 30.0),
            onCompleted: (value) {
              if (value != _oldPassword) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('You have to Write the Correct Password')));
              } else {
                BlocProvider.of<ProfileCubit>(context).setVerifiy(true);
                Navigator.pop(context);
              }
            },
            obscureText: true,
            obscuringCharacter: '*',
            textStyle: TextStyle(fontSize: _oldPassword.length <= 10 ? 20 : 16),
            appContext: context,
            length: _oldPassword.length,
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10.0)),
            child: MaterialButton(
                elevation: 10.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('You have to Verify the Password First')));
                }),
          )
        ],
      ),
    );
  }
}
