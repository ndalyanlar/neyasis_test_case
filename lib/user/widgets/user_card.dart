import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../generated/locale_keys.g.dart';
import 'user_card_fields.dart';
import '../../extensions/datetime_extension.dart';

import '../domain/models/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.editPressed,
    required this.removePressed,
  });
  final UserModel user;

  final VoidCallback removePressed;
  final VoidCallback editPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserCardField(text: "${user.name} ${user.surname}"),
            UserCardField(text: user.phoneNumber),
            UserCardField(text: user.identity),
            UserCardField(text: '${user.salary}'),
            UserCardField(text: user.birthDate.toViewFormat),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: removePressed,
                  child: const Text(LocaleKeys.delete).tr(),
                ),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                  onPressed: editPressed,
                  child: const Text(LocaleKeys.edit).tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
