import 'package:distech_technology/Features/ForgotPassword/Presentation/forgot_password.dart';
import 'package:distech_technology/Features/Home/Presentation/home_screen.dart';
import 'package:distech_technology/Features/Login/bloc/login_bloc.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User Login',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding / 2,
                  ),
                  Text(
                      'Enter your register mobile number for the verification process. We will send 4 digit code',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.darkGrey.withOpacity(0.8),
                          letterSpacing: 0.5)),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding * 2,
                  ),
                  CustomTextField(
                    isBorder: false,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 20,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                    controller: _usernameController,
                    hintText: 'Username',
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    isBorder: false,
                    obscureText: true,
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
                    controller: _passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding / 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
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
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding * 1.5,
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        context.pushReplacement(HomeScreen(
                          username: state.loginResponseModel.user!.fullName.toString()
                        ));
                      }
                      if (state is LoginErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(state.errorMsg)));
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      return FullButton(
                          label: 'Login',
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              context.read<LoginBloc>().add(UserLoginEvent(
                                  email: _usernameController.text,
                                  password: _passwordController.text));
                            }
                          });
                    },
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding * 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
