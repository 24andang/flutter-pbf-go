import 'package:dfa_pbf_fe/cubit/version/version_cubit.dart';
import 'package:dfa_pbf_fe/pages/setting/setting_page.dart';
import 'package:dfa_pbf_fe/widgets/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionNotification extends StatelessWidget {
  const VersionNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VersionCubit()..checkVersion(),
      child: BlocConsumer<VersionCubit, VersionState>(
        listener: (context, state) {
          if (state is VersionCheck) {
            if (state.newversion == true) {}
          }
        },
        builder: (context, state) {
          if (state is VersionCheck) {
            if (state.newversion == true) {
              return InkWell(
                onTap: () => Nav.to(context, SettingPage()),
                child: ListTile(
                  leading: CircularProgressIndicator(),
                  title: Text('ada update'),
                ),
              );
            } else {
              return Center(child: Text(''));
            }
          }
          return Center(child: Text('Version check error.'));
        },
      ),
    );
  }
}
