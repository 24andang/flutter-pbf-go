import 'package:dfa_pbf_fe/cubit/auth/auth_cubit.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/input.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstLoginPage extends StatefulWidget {
  const FirstLoginPage({super.key});

  @override
  State<FirstLoginPage> createState() => _FirstLoginPageState();
}

class _FirstLoginPageState extends State<FirstLoginPage> {
  final _key = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PBF GO!'),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: MediaQuery.of(context).size.height / 56,
            children: [
              Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: PbfColor.info,
                ),
              ),
              Text(
                'Untuk anda yang baru pertama kali login atau setelah password di-reset oleh administrator, maka sangat disarankan untuk anda meng-update password. Jangan lupakan passwordnya ya!',
              ),
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
                  MainBtn(
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
                          context.read<AuthCubit>().updatePassword(
                            _newPasswordController.text,
                          );
                        }
                      }
                    },
                  ),
                  DeleteBtn(
                    text: "Logout",
                    onclick: () {
                      context.read<AuthCubit>().logout();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
