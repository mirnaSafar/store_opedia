// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import '../../constant/privacy_policies.dart';

class PrivacyPlicies extends StatelessWidget {
  const PrivacyPlicies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policies"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Text(
                      privacy_policies[index],
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20.0,
                    ),
                itemCount: privacy_policies.length),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () => Navigator.pop(
                      context,
                    ),
                child: const Text("Hidden"))
          ],
        ),
      ),
    );
  }
}
