import 'package:dfa_pbf_fe/cubit/version/version_cubit.dart';
import 'package:dfa_pbf_fe/pages/main/pbf_drawer.dart';
import 'package:dfa_pbf_fe/pages/setting/update_password_page.dart';
import 'package:dfa_pbf_fe/widgets/nav.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VersionCubit>(
          create: (context) => VersionCubit()..checkVersion(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pengaturan'),
          foregroundColor: PbfColor.light,
          backgroundColor: PbfColor.main,
        ),
        drawer: PbfDrawer(),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(child: Icon(Icons.lock)),
                title: Text("Ubah Password"),
                onTap: () => Nav.to(context, UpdatePasswordPage()),
              ),
              ListTile(
                leading: CircleAvatar(child: Icon(Icons.new_releases)),
                title: Text("Version"),
                trailing: BlocBuilder<VersionCubit, VersionState>(
                  builder: (context, state) {
                    if (state is VersionCheck) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4,
                        children: [
                          Text(state.currentversion),
                          state.newversion == true
                              ? Text(
                                  '(Tersedia versi baru.)',
                                  style: TextStyle(color: PbfColor.fire),
                                )
                              : Text('(Versi terbaru.)'),
                        ],
                      );
                    }
                    return Text('');
                  },
                ),
                onTap: () => Nav.to(context, UpdatePasswordPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
