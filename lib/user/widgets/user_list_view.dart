import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/models/user_model.dart';
import '../providers/cubit/user_events_cubit.dart';
import 'add_edit_form.dart';
import 'user_card.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key, required this.users});
  final List<UserModel> users;
  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late List<UserModel> users;
  late bool isLoading;
  late final ScrollController _controller;
  @override
  void initState() {
    isLoading = false;
    users = widget.users;
    _controller = ScrollController()
      ..addListener(() async {
        final isLastPage = context.read<UserEventsCubit>().isLastPage;
        if (_controller.offset == _controller.position.maxScrollExtent) {
          if (!isLoading && !isLastPage) {
            setState(() {
              isLoading = !isLoading;
            });
            await context.read<UserEventsCubit>().loadMoreUsers();
            setState(() {
              isLoading = !isLoading;
            });
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const ClampingScrollPhysics(),
        controller: _controller,
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          return UserCard(
            editPressed: () async {
              final updatedUser = await showModalBottomSheet<UserModel?>(
                  isScrollControlled: true,
                  context: context,
                  builder: ((context) {
                    return AddEditForm(
                      userModel: user,
                    );
                  }));

              if (updatedUser != null) {
                setState(() {
                  users[users.indexOf(user)] = updatedUser;
                });
              }
            },
            removePressed: () async {
              await context.read<UserEventsCubit>().removeUser(userModel: user);
              setState(() {
                users.removeWhere((item) => item.id == user.id);
              });
            },
            user: user,
          );
        });
  }
}
