import 'package:flutter/material.dart';

class UserCardField extends StatelessWidget {
  const UserCardField({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
