import 'package:dfa_pbf_fe/pages/main/dashboard/dashboard_page.dart';
import 'package:dfa_pbf_fe/widgets/alert.dart';
import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:dfa_pbf_fe/widgets/nav.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String error;
  final String? detail;

  const ErrorPage({super.key, required this.error, this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 56,
                horizontal: MediaQuery.of(context).size.width / 56,
              ),
              child: Text(error),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                DeleteBtn(
                  text: "Detail",
                  onclick: () {
                    PbfAlert.info(
                      context,
                      title: "Error",
                      actionText: "Tutup",
                      content: detail.toString(),
                    );
                  },
                ),
                MainBtn(
                  text: "Dashboard",
                  onclick: () => Nav.to(context, DashboardPage()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
