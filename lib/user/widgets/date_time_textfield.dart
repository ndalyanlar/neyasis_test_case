import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:neyasis_test_case/extensions/datetime_extension.dart';

import '../../generated/locale_keys.g.dart';

class DateTimeTextField extends StatelessWidget {
  const DateTimeTextField({
    Key? key,
    required this.controllerDateOfBirth,
  }) : super(key: key);

  final TextEditingController controllerDateOfBirth;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        final date = await showDatePicker(
            context: context,
            initialDate: DateTime(1999),
            firstDate: DateTime(1930),
            lastDate: DateTime.now());
        if (date != null) {
          controllerDateOfBirth.text = date.toViewFormat;
        }
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: LocaleKeys.dateofbirth.tr(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.choose_date_of_birth.tr();
        }
        return null;
      },
      controller: controllerDateOfBirth,
      // user.identity,
    );
  }
}
