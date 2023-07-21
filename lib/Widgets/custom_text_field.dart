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
  final String? Function(String?)? onChanged;

  const CustomTextField({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != ''
            ? Text(
                labelText!,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            : const SizedBox(),
        labelText != ''
            ? const SizedBox(
                height: AppSizes.kDefaultPadding / 2,
              )
            : const SizedBox(),
        TextFormField(
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
                    contentPadding:
                        const EdgeInsets.all(AppSizes.kDefaultPadding),
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
      ],
    );
  }
}
