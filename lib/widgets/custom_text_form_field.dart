import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/core/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.readOnly = false,
    this.keyboardType,
    this.inputFormatters,
    this.textColor, // Add this line
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? textColor; // Add this line

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: textFormFieldWidget,
    )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => SizedBox(
    width: width ?? double.maxFinite,
    child: TextFormField(
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      autofocus: autofocus!,
      style: textStyle?.copyWith(color: textColor) ??
          CustomTextStyles.bodyMediumBluegray100.copyWith(color: textColor),
      obscureText: obscureText!,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
      decoration: decoration,
      readOnly: readOnly,
      validator: validator,
    ),
  );

  InputDecoration get decoration => InputDecoration(
    hintText: hintText ?? "",
    hintStyle: hintStyle?.copyWith(color: textColor) ?? CustomTextStyles.titleSmallWhiteA700.copyWith(color: textColor),
    prefixIcon: prefix,
    prefixIconConstraints: prefixConstraints,
    suffixIcon: suffix,
    suffixIconConstraints: suffixConstraints,
    isDense: true,
    contentPadding: contentPadding ?? EdgeInsets.all(19.h),
    fillColor: fillColor ?? appTheme.blueGray900,
    filled: filled,
    border: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide.none,
        ),
    enabledBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide.none,
        ),
    focusedBorder: borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.h),
          borderSide: BorderSide.none,
        ),
  );
}