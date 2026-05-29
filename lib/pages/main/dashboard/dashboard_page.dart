import 'package:dfa_pbf_fe/pages/main/dashboard/version_notification.dart';
import 'package:dfa_pbf_fe/pages/main/pbf_drawer.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        foregroundColor: PbfColor.light,
        backgroundColor: PbfColor.main,
      ),
      drawer: PbfDrawer(),
      body: Column(children: [VersionNotification()]),
    );
  }
}
