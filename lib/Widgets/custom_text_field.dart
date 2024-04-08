import 'package:flutter/material.dart';

import '../Commons/app_colors.dart';
import '../Commons/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final double? textSize;
  final bool? readOnly;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final bool? isBorder;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged? onChanged;
  final Function()? onTap;
  final double? height;
  TextCapitalization? textCapitalization;

  CustomTextField(
      {Key? key,
      required this.controller,
      this.hintText = '',
      this.labelText = '',
      this.errorText,
      this.minLines = 1,
      this.maxLines = 1,
      this.maxLength,
      this.validator,
      this.readOnly,
      this.keyboardType,
      this.obscureText,
      this.suffixIcon,
      this.onChanged,
      this.autoFocus = false,
      this.isBorder = true,
      this.prefixIcon,
      this.textAlign = TextAlign.start,
      this.textSize,
      this.focusNode,
      this.onTap,
      this.height,
      this.textCapitalization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
          textCapitalization:
              textCapitalization ?? TextCapitalization.characters,
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: readOnly ?? false,
          validator: validator,
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          minLines: minLines!,
          maxLines: maxLines!,
          maxLength: maxLength ?? 500,
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: AppColors.primary,
          controller: controller,
          onChanged: onChanged,
          autofocus: autoFocus!,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: textSize ?? 16.0, fontWeight: FontWeight.w400),
          textAlign: textAlign!,
          decoration:
              //isBorder! ?
              InputDecoration(
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  counterText: '',
                  contentPadding: EdgeInsets.all(AppSizes.kDefaultPadding),
                  hintText: hintText!,
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.secondary),
                  errorMaxLines: 2,
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  errorText: controller.text == "" ? errorText : null)
          // : InputDecoration(
          //     suffixIcon: suffixIcon,
          //     prefixIcon: prefixIcon,
          //     border: InputBorder.none,
          //     counterText: '',
          //     contentPadding:
          //         const EdgeInsets.all(AppSizes.kDefaultPadding),
          //     hintText: hintText!,
          //     hintStyle: Theme.of(context).textTheme.bodyMedium,
          //     labelStyle: Theme.of(context).textTheme.bodyLarge,
          //     errorText: controller.text == "" ? errorText : null),
          ),
    );
  }
}
