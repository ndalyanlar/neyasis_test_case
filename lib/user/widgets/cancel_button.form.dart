import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

class CancelButtonForm extends StatelessWidget {
  const CancelButtonForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: const Text(LocaleKeys.cancel).tr(),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
