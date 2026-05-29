import 'package:dfa_pbf_fe/cubit/user/user_cubit.dart';
import 'package:dfa_pbf_fe/models/user_model.dart';
import 'package:dfa_pbf_fe/pages/user/user_page.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/input.dart';
import 'package:dfa_pbf_fe/widgets/nav.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCreatePage extends StatefulWidget {
  const UserCreatePage({super.key});

  @override
  State<UserCreatePage> createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  final _key = GlobalKey<FormState>();
  final _initialController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is UserError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tambah User'),
            foregroundColor: PbfColor.light,
            backgroundColor: PbfColor.main,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width / 3
                : MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 96),
            child: Form(
              key: _key,
              child: Column(
                spacing: MediaQuery.of(context).size.height / 56,
                children: [
                  InputText(
                    controller: _initialController,
                    max: 3,
                    label: "Inisial",
                  ),
                  InputText(controller: _nameController, label: "Nama"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Builder(
                        builder: (btnContext) {
                          return MainBtn(
                            text: "Tambahkan",
                            onclick: () {
                              if (_key.currentState!.validate()) {
                                final user = UserCreateModel(
                                  initial: _initialController.text,
                                  name: _nameController.text,
                                );

                                btnContext.read<UserCubit>().createUser(user);
                                Nav.to(context, UserPage());
                              }
                            },
                          );
                        },
                      ),
                      BackBtn(text: "Kembali", backTo: UserPage()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
