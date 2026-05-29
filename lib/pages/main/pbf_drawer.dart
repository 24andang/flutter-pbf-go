import 'package:dfa_pbf_fe/cubit/auth/auth_cubit.dart';
import 'package:dfa_pbf_fe/pages/main/dashboard/dashboard_page.dart';
import 'package:dfa_pbf_fe/pages/main/pbf_drawer_menu.dart';
import 'package:dfa_pbf_fe/pages/product/product_page.dart';
import 'package:dfa_pbf_fe/pages/setting/setting_page.dart';
import 'package:dfa_pbf_fe/pages/stock/buffer/buffer_stock_page.dart';
import 'package:dfa_pbf_fe/pages/stock/inhand/in_hand_stock_page.dart';
import 'package:dfa_pbf_fe/pages/user/user_page.dart';
import 'package:dfa_pbf_fe/widgets/alert.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';

class PbfDrawer extends StatefulWidget {
  const PbfDrawer({super.key});

  @override
  State<PbfDrawer> createState() => _PbfDrawerState();
}

class _PbfDrawerState extends State<PbfDrawer> {
  bool dropStock = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    String? role;
    String? initial;
    String? name;

    if (auth is AuthLogin) {
      role = auth.loginuser.role;
      initial = auth.loginuser.initial;
      name = auth.loginuser.name;
    }

    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(initial.toString()),
            subtitle: Text(name.toString()),
          ),
          PbfDrawerMenu(
            icon: Icons.home,
            title: 'Dashboard',
            to: DashboardPage(),
          ),
          ListTile(
            leading: Icon(Icons.equalizer),
            title: Text('Stock'),
            trailing: dropStock
                ? Icon(Icons.arrow_drop_up)
                : Icon(Icons.arrow_drop_down),
            onTap: () {
              setState(() {
                dropStock = !dropStock;
              });
            },
          ),
          dropStock
              ? Container(
                  decoration: BoxDecoration(color: PbfColor.hover),
                  child: Column(
                    children: [
                      PbfDrawerMenu(
                        icon: Icons.grain,
                        title: 'In Hand',
                        to: InHandStockPage(),
                      ),
                      PbfDrawerMenu(
                        icon: Icons.blur_linear,
                        title: 'Buffer',
                        to: BufferStockPage(),
                      ),
                      PbfDrawerMenu(
                        icon: Icons.handyman_outlined,
                        title: 'Others',
                        to: ProductPage(),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          PbfDrawerMenu(
            icon: Icons.inventory_rounded,
            title: 'Produk',
            to: ProductPage(),
          ),
          PbfDrawerMenu(
            icon: Icons.settings,
            title: "Pengaturan",
            to: SettingPage(),
          ),
          if (role == 'ADMIN')
            PbfDrawerMenu(icon: Icons.person, title: 'User', to: UserPage()),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              PbfAlert.confirm(
                context,
                title: "Anda akan logout ?",
                actionText: "Ya, Logout!",
                onConfirm: () {
                  Navigator.pop(context);
                  context.read<AuthCubit>().logout();
                  Restart.restartApp();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
