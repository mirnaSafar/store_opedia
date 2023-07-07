import 'package:flutter/material.dart';

import '../shared/custom_widgets/custom_text.dart';

class UserStore extends StatefulWidget {
  const UserStore({Key? key}) : super(key: key);

  @override
  State<UserStore> createState() => _UserStoreState();
}

class _UserStoreState extends State<UserStore> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height / 3,
        ),
        Center(
          child: Column(
            children: [
              const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 75,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const CustomText(
                text: "You don't have any stroe yet",
                bold: true,
                fontSize: 25,
              )
            ],
          ),
        ),
      ],
    );
  }
}
