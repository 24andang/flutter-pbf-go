import 'package:dfa_pbf_fe/cubit/user/user_cubit.dart';
import 'package:dfa_pbf_fe/pages/main/dashboard/dashboard_page.dart';
import 'package:dfa_pbf_fe/pages/product/product_page.dart';
import 'package:dfa_pbf_fe/pages/setting/setting_page.dart';
import 'package:dfa_pbf_fe/pages/user/user_create_page.dart';
import 'package:dfa_pbf_fe/pages/user/user_page.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _index = 0;

  final List<Map<String, dynamic>> pages = [
    {'title': 'Dashboard', 'page': DashboardPage(), 'fab': null},
    {'title': 'Produk', 'page': ProductPage(), 'fab': null},
    {'title': 'Setting', 'page': SettingPage(), 'fab': null},
    {'title': 'User', 'page': UserPage(), 'fab': UserCreatePage()},
  ];

  @override
  Widget build(BuildContext context) {
    final currentPage = pages[_index];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentPage['title']),
        foregroundColor: PbfColor.light,
        backgroundColor: PbfColor.main,
      ),

      body: currentPage['page'],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => currentPage['fab']),
          );

          if (result == true) {
            UserCubit().getAllUsers();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
