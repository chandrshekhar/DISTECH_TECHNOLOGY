import 'package:distech_technology/Controller/Login%20Controller/login_controller.dart';
import 'package:distech_technology/Features/ForgotPassword/Presentation/forgot_password.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:easy_localization/easy_localization.dart';
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
                    Text('login',
                            style: Theme.of(context).textTheme.headlineMedium)
                        .tr(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('loginText',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppColors.darkGrey.withOpacity(0.8),
                                    //color: AppColors.primary,
                                    letterSpacing: 0.5))
                        .tr(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 20,
                        ),
                        contentPadding:
                            EdgeInsets.all(AppSizes.kDefaultPadding),
                      ),
                      autocorrect: false,
                      inputFormatters: const [
                        // UpperCaseTextFormatter(),
                        // LengthLimitingTextInputFormatter(12)
                      ],
                      enableSuggestions: false,
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
                    userLoginController.isLoading.value == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : FullButton(
                            label: tr('login'),
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
