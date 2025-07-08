import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.minLines,
  });
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: textRegular,
      obscureText: isShow,
      onChanged: widget.onChanged,
      validator: widget.validator,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines ?? 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColor.grey500,
        suffixIcon: InkWell(
          onTap: () => setState(() => isShow = !isShow),
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              isShow
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: isShow ? AppColor.grey500 : Colors.black,
            ),
          ),
        ),
        hintText: widget.hintText ?? '',
        hintStyle: textRegular.copyWith(color: AppColor.grey500),
        errorMaxLines: 4,
        errorStyle: textRegular.copyWith(color: AppColor.red500),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.red500),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey500),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey500),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey100),
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
