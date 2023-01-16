import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../generated/locale_keys.g.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.controller,
    required this.title,
    required this.validator,
    this.inputFormatter,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatter;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: title,
      ),
      validator: validator,
      inputFormatters: inputFormatter,
      controller: controller,
      // "${user.name} ${user.surname}",
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
