import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatefulWidget {
  const InputText({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.minLines,
    this.readOnly,
    this.autofocus,
    this.onTap,
    this.borderRadius = 12,
    this.keyboardType,
    this.inputFormatters,
  });
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final bool? autofocus;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: textRegular,
      autofocus: widget.autofocus ?? false,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines ?? 1,
      inputFormatters: widget.inputFormatters ?? [],
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap ?? () {},
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColor.grey500,
        suffixIcon: widget.suffixIcon,
        suffixIconColor: AppColor.grey500,
        hintText: widget.hintText ?? '',
        hintStyle: textRegular.copyWith(color: AppColor.grey500),
        errorMaxLines: 4,
        errorStyle: textRegular.copyWith(color: AppColor.red500),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.red500),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey500),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey500),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey100),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
        ),
      ),
    );
  }
}
