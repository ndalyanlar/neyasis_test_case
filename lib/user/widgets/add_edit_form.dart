import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/locale_keys.g.dart';
import '../../extensions/datetime_extension.dart';
import '../domain/service/user_service.dart';
import '../providers/cubit/user_events_cubit.dart';

import '../domain/models/user_model.dart';

class AddEditForm extends StatefulWidget {
  const AddEditForm({
    Key? key,
    this.userModel,
  }) : super(key: key);
  final UserModel? userModel;

  @override
  State<AddEditForm> createState() => _AddEditFormState();
}

class _AddEditFormState extends State<AddEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final focusNodeButtonSubmit = FocusNode();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSurname = TextEditingController();
  TextEditingController controllerIdentity = TextEditingController();
  TextEditingController controllerDateOfBirth = TextEditingController();
  TextEditingController controllerSalary = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  late bool isEdit;

  @override
  void initState() {
    isEdit = widget.userModel != null;

    if (isEdit) {
      controllerName.text = widget.userModel!.name;
      controllerSurname.text = widget.userModel!.surname;
      controllerIdentity.text = widget.userModel!.identity;
      controllerDateOfBirth.text = widget.userModel!.birthDate.toViewFormat;
      controllerSalary.text =
          widget.userModel!.salary.toStringAsFixed(2).toString();
      controllerPhone.text = widget.userModel!.phoneNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: BlocConsumer<UserEventsCubit, UsersState>(
        builder: ((context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: LocaleKeys.name.tr(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return LocaleKeys.type_name.tr();
                      return null;
                    },
                    controller: controllerName,
                    // "${user.name} ${user.surname}",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: LocaleKeys.surname.tr(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return LocaleKeys.type_surname.tr();
                      return null;
                    },
                    controller: controllerSurname,
                    // user.phoneNumber,
                  ),
                  TextFormField(
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
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
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: LocaleKeys.identitiy.tr(),
                    ),

                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value!.isEmpty || value.characters.length != 11) {
                        return LocaleKeys.please_correct_identity.tr();
                      }
                      return null;
                    },
                    controller: controllerIdentity,
                    // '${user.salary}',
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: LocaleKeys.phone.tr(),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value!.isEmpty && value.characters.length != 10) {
                        return LocaleKeys.please_type_phone.tr();
                      }
                      return null;
                    },
                    controller: controllerPhone,
                    // '${user.birthDate}',
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: LocaleKeys.salary.tr(),
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.please_type_phone.tr();
                      }
                      return null;
                    },
                    controller: controllerSalary,
                    // '${user.birthDate}',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        child: const Text(LocaleKeys.cancel).tr(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        child: isEdit
                            ? const Text(LocaleKeys.update).tr()
                            : const Text(LocaleKeys.add).tr(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final user = UserModel(
                              name: controllerName.text.trim(),
                              surname: controllerSurname.text.trim(),
                              identity: controllerIdentity.text.trim(),
                              phoneNumber: controllerPhone.text.trim(),
                              id: isEdit ? widget.userModel!.id.toString() : "",
                              salary: double.tryParse(
                                      controllerSalary.text.trim()) ??
                                  0,
                              birthDate:
                                  controllerDateOfBirth.text.toDateTimeFormat,
                            );

                            if (isEdit) {
                              await context
                                  .read<UserEventsCubit>()
                                  .editUser(userModel: user)
                                  .then((value) =>
                                      Navigator.of(context).pop(user));
                            } else {
                              await context
                                  .read<UserEventsCubit>()
                                  .addUser(userModel: user)
                                  .then((value) =>
                                      Navigator.of(context).pop(user));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
        listener: ((context, state) {
          if (state is UserEventsError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is UserSuccessEvents) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text("${state.userModel.name} ${state.type.name.tr()}")));
          }
        }),
      ),
      create: (BuildContext context) {
        return UserEventsCubit(UserService());
      },
    );
  }
}
