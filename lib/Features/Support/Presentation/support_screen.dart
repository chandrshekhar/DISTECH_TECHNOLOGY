import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  //Variable Declarations
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Hide the onscreen keyboard on outside touch.
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              Text(
                'Support',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: AppSizes.kDefaultPadding * 1.2,
              ),
              CustomTextField(
                controller: _subjectController,
                hintText: 'Subject',
                isBorder: false,
                maxLines: 1,
                minLines: 1,
              ),
              const SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              CustomTextField(
                isBorder: false,
                controller: _messageController,
                hintText: 'Message',
                maxLines: 5,
                minLines: 5,
              ),
              const SizedBox(
                height: AppSizes.kDefaultPadding * 2,
              ),
              FullButton(label: 'Submit Query', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
