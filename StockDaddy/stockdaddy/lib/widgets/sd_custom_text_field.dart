import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SDCustomTextField extends StatelessWidget {
  const SDCustomTextField({
    Key? key,
    this.icon,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.hintText,
    required this.label,
    required this.onChange,
  }) : super(key: key);

  final String label;
  final bool isObscure;
  final String? hintText;
  final TextInputType keyboardType;
  final IconData? icon;
  final Function(String text) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.black, fontSize: 14.sp)),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          keyboardType: keyboardType,
          onChanged: onChange,
          obscureText: isObscure,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
            prefixIcon: icon == null ? null : Icon(icon, color: Colors.black),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
