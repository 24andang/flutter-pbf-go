import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool? obscure;
  final int? max;
  final TextCapitalization? cap;
  final Widget? suffix;

  const InputText({
    super.key,
    required this.controller,
    required this.label,
    this.obscure,
    this.max,
    this.cap,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: max,
      textCapitalization: cap ?? TextCapitalization.none,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        label: Text(label),
        counterText: '',
        border: OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        suffix: suffix,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tidak boleh dikosongkan';
        }
        return null;
      },
    );
  }
}
