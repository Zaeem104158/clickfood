import 'package:flutter/material.dart';

class CustomeTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onKeyBoardPressSubmitted;
  final Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? filledColor;
  final Color? borderColor;
  final bool obscureText;
  final bool autofocus;
  final int? textMaxLength;
  final TextStyle? inputStyle;
  final TextStyle? labelStyle;
  const CustomeTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.maxLines = 1,
    this.textMaxLength,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onKeyBoardPressSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.filledColor,
    this.borderColor,
    this.obscureText = false,
    this.autofocus = false,
    this.inputStyle,
    this.labelStyle,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      maxLines: maxLines,
      maxLength: textMaxLength,
      style: inputStyle,
      validator: validator,
      onFieldSubmitted: onKeyBoardPressSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        //floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: labelStyle,
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey, // Enabled border color
            width: 1.5,
          ),
        ),
        // Focused border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.blue, // Focused border color
            width: 2.0,
          ),
        ),
        // Error border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red, // Error border color
            width: 1.5,
          ),
        ),
        // Border when error is active and focused
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.redAccent, // Focused error border color
            width: 2.0,
          ),
        ),
        // Content padding for better alignment
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
      ),
      cursorColor: Colors.black,
    );
  }
}
