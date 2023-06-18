import 'package:flutter/material.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:ngetrip/core/themes.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isValidate;
  final bool obscureText;
  final String label;
  const AppTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.label,
    this.isValidate = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      validator: (val) {
        if (widget.isValidate) {
          if (val!.isEmpty) {
            var validatorMessageText = '${widget.label} must be required!';
            return validatorMessageText;
          }
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.label,
        hintStyle: textGray14,
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColor.blackFont,
                  size: 14,
                ),
              )
            : null,
      ),
    );
  }
}
