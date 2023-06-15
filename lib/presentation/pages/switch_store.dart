import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';

class SwitchStore extends StatefulWidget {
  const SwitchStore({Key? key}) : super(key: key);

  @override
  State<SwitchStore> createState() => _SwitchStoreState();
}

void _showAlertDialog(BuildContext context) {
  AwesomeDialog(
          btnOkColor: Colors.green,
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.QUESTION,
          body: const Center(
            child: Text(
              'Select this shop ?',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          btnCancelOnPress: () {},
          btnCancelText: 'Cancel',
          btnOkText: " Countinue",
          btnOkOnPress: () {})
      .show();
}

class _SwitchStoreState extends State<SwitchStore> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shops"),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        children: [
          buildShopItem(context, height),
          buildShopItem(context, height),
          buildShopItem(context, height),
          buildShopItem(context, height),
          buildShopItem(context, height),
          buildShopItem(context, height),
          buildShopItem(context, height),
        ],
      ),
    );
  }
}

Widget buildShopItem(BuildContext context, var height) => GestureDetector(
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 60,
            child: Image.asset('assets/verified.png'),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          const CustomText(text: "Shop Name")
        ],
      ),
      onTap: () => _showAlertDialog(context),
    );
