import 'package:flutter/material.dart';

class PbfDrawerMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget to;

  const PbfDrawerMenu({
    super.key,
    required this.icon,
    required this.title,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => to),
      ),
    );
  }
}
