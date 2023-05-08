import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback? handler;
  final String text;

  const MenuButton({super.key, required this.text, required this.handler});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 160, child: FilledButton(onPressed: handler, child: Text(text)));
  }
}
