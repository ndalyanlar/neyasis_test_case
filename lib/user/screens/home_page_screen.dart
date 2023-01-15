import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neyasis_test_case/core/localization.dart';

import '../../generated/locale_keys.g.dart';
import '../domain/index.dart';
import '../providers/index.dart';
import '../widgets/index.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserModel> users = [];
  bool isLoading = false;
  late UserEventsCubit cubit;
  @override
  void initState() {
    cubit = UserEventsCubit(UserService());
    cubit.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.users).tr(),
          actions: [
            IconButton(
                onPressed: () {
                  if (context.locale == MyLocalization.tr) {
                    context.setLocale(MyLocalization.en);
                  } else {
                    context.setLocale(MyLocalization.tr);
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.language))
          ],
        ),
        body: BlocConsumer<UserEventsCubit, UsersState>(
            listener: (context, state) {
          final isLastPage = context.read<UserEventsCubit>().isLastPage;
          if (state is UserEventsError) {
            showSnackbar(context, state.message);
          } else if (state is UserSuccessEvents) {
            showSnackbar(
                context, "${state.userModel.name} ${state.type.name.tr()}");
          } else if (state is UserListLoaded &&
              isLastPage &&
              users.isNotEmpty) {
            showSnackbar(context, LocaleKeys.lastPage.tr(), color: Colors.red);
          }
        }, builder: (context, state) {
          if (state is UserListLoading) {
            return const PreloaderListView();
          } else if (state is UserListLoaded) {
            users = state.users;
          }
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: UserListView(users: users),
                ),
                if (state is PaginationLoading) const PaginationLoader(),
              ],
            ),
          );
        }),
        floatingActionButton: AddUserButton(
          users: users,
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String text, {Color? color}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(text)));
  }
}
