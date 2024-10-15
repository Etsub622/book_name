import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final String sign;

  const CustomTextField(
      {super.key, required this.controller, this.maxLines = 1, this.sign = ''});
      
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: sign.isEmpty
              ? null
              : Icon(
                  Icons.money_off_csred_outlined,
                  size: 18,
                )),
      maxLines: maxLines,
    );
  }
}
