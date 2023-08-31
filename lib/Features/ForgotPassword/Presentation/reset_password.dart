import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Features/Login/Presentation/login_screen.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../Commons/app_colors.dart';
import '../../../Commons/app_images.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_shape_clipper.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../../Widgets/full_button.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatefulWidget {
  String email;
  String slug;

  ResetPasswordScreen({Key? key, required this.email, required this.slug})
      : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  //Variable Declarations
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
                clipper: CustomShape(),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    padding:  EdgeInsets.symmetric(
                        horizontal: AppSizes.kDefaultPadding),
                    decoration:
                        const BoxDecoration(gradient: AppColors.radialGradient),
                    child: SafeArea(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                           SizedBox(
                            height: AppSizes.kDefaultPadding,
                          ),
                          Image.asset(
                            AppImages.appLogo,
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ])))),
            Padding(
              padding:  EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding),
              child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reset Password',
                        style: Theme.of(context).textTheme.headlineMedium),
                     SizedBox(
                      height: AppSizes.kDefaultPadding / 2,
                    ),
                    Text(
                        'Set the new password for your account so you can login and access all the features',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkGrey.withOpacity(0.8),
                            letterSpacing: 0.5)),
                     SizedBox(
                      height: AppSizes.kDefaultPadding * 2,
                    ),
                    CustomTextField(
                      isBorder: false,
                      prefixIcon: const Icon(
                        Icons.keyboard,
                        size: 20,
                      ),
                      hintText: 'Set new password',
                      obscureText: true,
                      controller: _newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'New Password can\'t be empty';
                        }
                        return null;
                      },
                    ),
                     SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                    CustomTextField(
                      isBorder: false,
                      prefixIcon: const Icon(
                        Icons.keyboard,
                        size: 20,
                      ),
                      obscureText: true,
                      hintText: 'Confirm new password',
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password can\'t be empty';
                        }
                        return null;
                      },
                    ),
                     SizedBox(
                      height: AppSizes.kDefaultPadding * 2,
                    ),
                    FullButton(
                        label: 'Continue',
                        onPressed: () async {
                          var res = await ApiProvider().resetPassword(
                              widget.email,
                              _newPasswordController.text.trim(),
                              _confirmPasswordController.text.trim(), widget.slug);

                          if (res['success'] == true) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(res['message'].toString())));
                            // ignore: use_build_context_synchronously
                            context.pushReplacement(const LoginScreen());
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(res['error'].toString())));
                          }
                        }),
                     SizedBox(
                      height: AppSizes.kDefaultPadding * 1.5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
