import 'package:flutter/material.dart';

class WaitingIndicator extends StatelessWidget {
  const WaitingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Text(
          "WAITING OPPONENT",
          style: TextStyle(fontSize: 20),
        ),
        Container(
            width: 200,
            margin: const EdgeInsets.only(top: 40),
            child: const CircularProgressIndicator()),
      ],
    ));
  }
}
