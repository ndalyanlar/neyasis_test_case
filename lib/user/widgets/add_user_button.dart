import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../generated/locale_keys.g.dart';

import '../domain/models/user_model.dart';
import 'add_edit_form.dart';

class AddUserButton extends StatefulWidget {
  const AddUserButton({
    Key? key,
    required this.users,
  }) : super(key: key);
  final List<UserModel> users;
  @override
  State<AddUserButton> createState() => _AddUserButtonState();
}

class _AddUserButtonState extends State<AddUserButton> {
  @override
  void didUpdateWidget(covariant AddUserButton oldWidget) {
    if (oldWidget.users != widget.users) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final newUser = await showModalBottomSheet<UserModel?>(
            isScrollControlled: true,
            context: context,
            builder: ((context) {
              return const AddEditForm();
            }));

        if (newUser != null) {
          setState(() {
            widget.users.add(newUser);
          });
        }
      },
      tooltip: LocaleKeys.add.tr(),
      child: const Icon(Icons.add),
    );
  }
}
