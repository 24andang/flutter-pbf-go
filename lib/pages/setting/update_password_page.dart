import 'package:dfa_pbf_fe/cubit/user/user_cubit.dart';
import 'package:dfa_pbf_fe/pages/setting/setting_page.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/input.dart';
import 'package:dfa_pbf_fe/widgets/nav.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _key = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isVisible = true;

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
            title: Text('Update Password'),
            foregroundColor: PbfColor.light,
            backgroundColor: PbfColor.main,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width > 640
                  ? MediaQuery.of(context).size.width / 56
                  : MediaQuery.of(context).size.width / 36,
            ),
            width: MediaQuery.of(context).size.width > 640
                ? MediaQuery.of(context).size.width / 3
                : MediaQuery.of(context).size.width,
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: MediaQuery.of(context).size.height / 56,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: InputText(
                      controller: _newPasswordController,
                      obscure: _isVisible,
                      label: "Password Baru",
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible
                            ? Icon(Icons.visibility_off_outlined)
                            : Icon(Icons.visibility_outlined),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: InputText(
                      controller: _confirmPasswordController,
                      obscure: _isVisible,
                      label: "Konfirmasi Password Baru",
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible
                            ? Icon(Icons.visibility_off_outlined)
                            : Icon(Icons.visibility_outlined),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (btnContext) {
                          return MainBtn(
                            text: "Ubah",
                            onclick: () {
                              if (_key.currentState!.validate()) {
                                if (_newPasswordController.text !=
                                    _confirmPasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Konfirmarsi password tidak sesuai.",
                                      ),
                                    ),
                                  );
                                } else {
                                  btnContext.read<UserCubit>().updatePassword(
                                    _newPasswordController.text,
                                  );
                                  Nav.to(context, SettingPage());
                                }
                              }
                            },
                          );
                        },
                      ),
                      BackBtn(text: "Batalkan", backTo: SettingPage()),
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
