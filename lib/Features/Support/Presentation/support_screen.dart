import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Support%20Controller/support_controller.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  //Variable Declarations
  final supportController = Get.put(SupportController());
  ApiProvider apiProvider = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Hide the onscreen keyboard on outside touch.
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              Text(
                'Support',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
               SizedBox(
                height: AppSizes.kDefaultPadding * 1.2,
              ),
              CustomTextField(
                controller: supportController.subjectController.value,
                hintText: 'Subject',
                isBorder: false,
                maxLines: 1,
                minLines: 1,
              ),
               SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              CustomTextField(
                isBorder: false,
                controller: supportController.messageController.value,
                hintText: 'Message',
                maxLines: 5,
                minLines: 5,
              ),
               SizedBox(
                height: AppSizes.kDefaultPadding * 2,
              ),
              Obx(() => supportController.isLoading.value == true
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : FullButton(
                      label: 'Submit Query',
                      onPressed: () {
                        if (supportController
                                .subjectController.value.text.isNotEmpty &&
                            supportController
                                    .messageController.value.text.length >
                                5) {
                          supportController.supportMethod();
                        } else {
                          Get.snackbar("Error",
                              "Subject and Message is required and Message length should be at least 10",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              isDismissible: true,
                              snackPosition: SnackPosition.BOTTOM);
                        }

                        //   apiProvider
                        //       .userSupportApimethod(
                        //           subject: _subjectController.text.trim(),
                        //           message: _messageController.text.trim())
                        //       .then((value) {
                        //     if (value) {
                        //       if (kDebugMode) {
                        //         print("query submited");
                        //       }
                        //       setState(() {
                        //         _subjectController.clear();
                        //         _messageController.clear();
                        //       });
                        //     } else {

                        //       if (kDebugMode) {
                        //         print("something went wrong");
                        //       }
                        //     }
                        //   });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
