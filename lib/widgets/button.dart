import 'package:dfa_pbf_fe/widgets/nav.dart';
import 'package:dfa_pbf_fe/widgets/style.dart';
import 'package:flutter/material.dart';

class MainBtn extends StatelessWidget {
  final void Function()? onclick;
  final String text;

  const MainBtn({super.key, required this.text, required this.onclick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: PbfColor.main,
        foregroundColor: PbfColor.light,
      ),
      onPressed: onclick,
      child: Text(text),
    );
  }
}

class FloatAddBtn extends StatelessWidget {
  final Widget to;

  const FloatAddBtn({super.key, required this.to});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Nav.to(context, to),
      backgroundColor: PbfColor.info,
      foregroundColor: PbfColor.light,
      child: Icon(Icons.add),
    );
  }
}

class PopBtn extends StatelessWidget {
  final String text;

  const PopBtn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: PbfColor.grey,
        foregroundColor: PbfColor.light,
      ),
      onPressed: () => Navigator.pop(context),
      child: Text(text),
    );
  }
}

class BackBtn extends StatelessWidget {
  final String text;
  final Widget backTo;

  const BackBtn({super.key, required this.text, required this.backTo});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: PbfColor.grey,
        foregroundColor: PbfColor.light,
      ),
      onPressed: () => Nav.to(context, backTo),
      child: Text(text),
    );
  }
}

class DeleteBtn extends StatelessWidget {
  final void Function()? onclick;
  final String text;

  const DeleteBtn({super.key, required this.text, required this.onclick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: PbfColor.fire,
        foregroundColor: PbfColor.light,
      ),
      onPressed: onclick,
      child: Text(text),
    );
  }
}
