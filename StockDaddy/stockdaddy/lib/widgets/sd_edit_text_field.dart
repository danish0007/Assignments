import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SDEditTextField extends StatelessWidget {
  const SDEditTextField({
    Key? key,
    this.icon,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.minLines = 1,
    required this.label,
    required this.onChange,
  }) : super(key: key);

  final String label;
  final bool isObscure;
  final String? hintText;
  final TextInputType keyboardType;
  final IconData? icon;
  final int minLines;
  final Function(String text) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          minLines: minLines,
          maxLines: 10,
          keyboardType: keyboardType,
          onChanged: onChange,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: icon == null ? null : Icon(icon, color: Colors.white),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
