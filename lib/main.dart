import 'package:dfa_pbf_fe/cubit/auth/auth_cubit.dart';
import 'package:dfa_pbf_fe/pages/auth/first_login_page.dart';
import 'package:dfa_pbf_fe/pages/auth/login_page.dart';
import 'package:dfa_pbf_fe/pages/main/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthState>(
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
          builder: (context, state) {
            print('state saat ini $state');
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is AuthLogin) {
              if (state.loginuser.isSet == null ||
                  state.loginuser.isSet == 'r') {
                return FirstLoginPage();
              }
              return DashboardPage();
            }

            return LoginPage();
          },
        ),
      ),
    );
  }
}
