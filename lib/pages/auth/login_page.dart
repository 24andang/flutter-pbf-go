import 'package:dfa_pbf_fe/cubit/auth/auth_cubit.dart';
import 'package:dfa_pbf_fe/models/pbf_auth_model.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/input.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final _initialController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Center(
          child: Container(
            margin: EdgeInsets.all(
              MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width / 56
                  : MediaQuery.of(context).size.width / 16,
            ),
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width / 56
                  : MediaQuery.of(context).size.width / 16,
            ),
            width: MediaQuery.of(context).size.width > 700
                ? MediaQuery.of(context).size.width / 4
                : MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: MediaQuery.of(context).size.height / 64,
                children: [
                  Text(
                    "PBF GO!",
                    style: TextStyle(
                      color: PbfColor.main,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 12,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: InputText(
                      controller: _initialController,
                      max: 3,
                      cap: TextCapitalization.characters,
                      label: "Inisial",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: InputText(
                      controller: _passwordController,
                      obscure: _isVisible,
                      label: "Password",
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
                  MainBtn(
                    text: "Login",
                    onclick: () {
                      if (_key.currentState!.validate()) {
                        final user = PbfAuthModel(
                          initial: _initialController.text,
                          password: _passwordController.text,
                        );

                        context.read<AuthCubit>().login(user);
                      }
                    },
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
