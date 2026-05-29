import 'package:dfa_pbf_fe/cubit/user/user_cubit.dart';
import 'package:dfa_pbf_fe/pages/main/error_page.dart';
import 'package:dfa_pbf_fe/pages/main/pbf_drawer.dart';
import 'package:dfa_pbf_fe/pages/user/user_create_page.dart';
import 'package:dfa_pbf_fe/widgets/alert.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getAllUsers(),
      child: BlocConsumer<UserCubit, UserState>(
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
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text('User'),
                foregroundColor: PbfColor.light,
                backgroundColor: PbfColor.main,
              ),
              drawer: PbfDrawer(),
              body: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  var user = state.users[index];
                  return InkWell(
                    onTap: () {},
                    hoverColor: PbfColor.hover,
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: user.role == "ADMIN"
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: MediaQuery.of(context).size.width / 96,
                              children: [
                                Text(user.initial),
                                Text(
                                  '(${user.role})',
                                  style: TextStyle(
                                    color: PbfColor.info,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        MediaQuery.of(context).size.height / 56,
                                  ),
                                ),
                              ],
                            )
                          : Text(user.initial),
                      subtitle: Text(user.name),
                      trailing: Wrap(
                        spacing: 12,
                        children: [
                          IconButton(
                            color: PbfColor.info,
                            onPressed: () {
                              final userCubit = context.read<UserCubit>();
                              PbfAlert.confirm(
                                context,
                                title: "Reset password user: ${user.initial} ?",
                                actionText: "Ya, Reset!",
                                onConfirm: () =>
                                    userCubit.resetPassword(user.initial),
                              );
                            },
                            icon: Icon(Icons.lock_reset_outlined),
                          ),
                          IconButton(
                            color: PbfColor.fire,
                            onPressed: () {
                              final userCubit = context.read<UserCubit>();
                              PbfAlert.confirm(
                                context,
                                title:
                                    "Anda yakin menghapus user ${user.initial} ?",
                                actionText: "Ya, Hapus!",
                                onConfirm: () =>
                                    userCubit.deleteUser(user.initial),
                              );
                            },
                            icon: Icon(Icons.delete_forever_rounded),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatAddBtn(to: UserCreatePage()),
            );
          } else if (state is UserError) {
            return ErrorPage(error: state.message);
          }
          return ErrorPage(error: "Gagal memuat halaman user.");
        },
      ),
    );
  }
}
