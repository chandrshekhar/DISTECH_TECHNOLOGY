import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/ForgotPassword/Presentation/reset_password.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../Commons/app_colors.dart';
import '../../../Commons/app_images.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_shape_clipper.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String pinOtp = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipPath(
          clipper: CustomShape(),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding),
              decoration:
                  const BoxDecoration(gradient: AppColors.radialGradient),
              child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                    Image.asset(
                      AppImages.appLogo,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ])))),
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter 6 Digit Code',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(
              height: AppSizes.kDefaultPadding,
            ),
            Text(
                'Enter 6 digit code that you received on your registered mail ${widget.email}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.darkGrey.withOpacity(0.8),
                    letterSpacing: 0.5)),
            const SizedBox(
              height: AppSizes.kDefaultPadding * 2,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: MediaQuery.of(context).size.width/9,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceBetween,
              fieldStyle: FieldStyle.box,
              onChanged: (value) {
               
               
              },
              onCompleted: (pin) {
                 setState(() {
                  pinOtp = pin;
                });   
              },
            ),
            const SizedBox(
              height: AppSizes.kDefaultPadding * 2,
            ),
            FullButton(
                label: 'Continue',
                onPressed: () async {
                  var res = await ApiProvider().verifyOtp(widget.email, pinOtp);
                  if (res['success'] == true) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(res['message'].toString())));
                    // ignore: use_build_context_synchronously
                    context.pushReplacement( ResetPasswordScreen(email: widget.email, slug: res['slug'],));
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(res['error'].toString())));
                  }
                }),
            const SizedBox(
              height: AppSizes.kDefaultPadding * 2,
            ),
          ],
        ),
      )
    ])));
  }
}
