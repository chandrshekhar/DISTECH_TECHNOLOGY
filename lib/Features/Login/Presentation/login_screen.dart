import 'package:distech_technology/Controller/Login%20Controller/login_controller.dart';
import 'package:distech_technology/Features/ForgotPassword/Presentation/forgot_password.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_images.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_shape_clipper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Variable Declarations
  final userLoginController = Get.put(LoginController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
                clipper: CustomShape(),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.kDefaultPadding),
                    decoration: const BoxDecoration(
                      gradient: AppColors.radialGradient,
                    ),
                    child: SafeArea(
                        bottom: true,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.appLogo,
                                //width: MediaQuery.of(context).size.width * 0.6,
                              ),
                            ])))),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
              child: Obx(
                () => Column(
                  //  shrinkWrap: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User Login',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        'Enter your register mail id and password for the verification process and login.',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.darkGrey.withOpacity(0.8),
                            //color: AppColors.primary,
                            letterSpacing: 0.5)),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 20,
                        ),
                        contentPadding:
                            EdgeInsets.all(AppSizes.kDefaultPadding),
                      ),
                      inputFormatters: const [
                        // UpperCaseTextFormatter(),
                      ],
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                      controller: userLoginController.userNameController.value,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      isBorder: false,
                      obscureText: !passwordVisible,
                      prefixIcon: const Icon(
                        Icons.keyboard,
                        size: 20,
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      controller: userLoginController.passwordController.value,
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: AppSizes.caption,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            context.push(const ForgotPassword());
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w400),
                          )),
                    ),
                    userLoginController.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : FullButton(
                            label: 'Login',
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                userLoginController.userLogin(context);
                              }
                            })
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
