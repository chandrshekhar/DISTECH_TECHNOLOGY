import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Features/Profile/Presentation/edit_profile_screen.dart';
import 'package:distech_technology/Features/Profile/Widgets/profile_item_widget.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Commons/app_colors.dart';
import '../../../Widgets/custom_shape_clipper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'My Profile',
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      height: 130,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.darkGrey,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                          maxRadius: 60,
                          minRadius: 60,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: AppSizes.kDefaultPadding,
              ),
              profileController.isLoading.value
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.kDefaultPadding),
                        child: ListView(
                          children: [
                            ProfileItemWidget(
                                title: 'Full Name',
                                value: profileController.userProfileModel.value
                                        .user!.fullName ??
                                    ""),
                            //const ProfileItemWidget(title: 'Last Name', value: 'Paul'),
                            ProfileItemWidget(
                                title: 'Aadhaar ID',
                                value: profileController.userProfileModel.value
                                        .user!.aadhaarId ??
                                    ""),
                            ProfileItemWidget(
                                title: 'Pan Number',
                                value: profileController.userProfileModel.value
                                        .user!.panNumber ??
                                    ""),
                            ProfileItemWidget(
                                title: 'Address 1',
                                value:
                                    '${profileController.userProfileModel.value.user!.address1}\n${profileController.userProfileModel.value.user!.address2}'),
                            ProfileItemWidget(
                                title: 'PIN Code',
                                value: profileController
                                        .userProfileModel.value.user!.pinCode ??
                                    ""),
                            SizedBox(
                              height: AppSizes.kDefaultPadding,
                            ),
                            Text(
                              'Other Information'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color:
                                          AppColors.darkGrey.withOpacity(0.8)),
                            ),
                            SizedBox(
                              height: AppSizes.kDefaultPadding / 2,
                            ),
                            const CustomDivider(),
                            SizedBox(
                              height: AppSizes.kDefaultPadding,
                            ),
                            ProfileItemWidget(
                                title: 'Mobile Number',
                                value: profileController.userProfileModel.value
                                        .user!.mobileNumber ??
                                    ""),
                            ProfileItemWidget(
                                title: 'Email ID',
                                value: profileController
                                        .userProfileModel.value.user!.email ??
                                    ""),
                            ProfileItemWidget(
                                title: 'Trade License Number',
                                value: profileController.userProfileModel.value
                                        .user!.tradeLicenseNumber ??
                                    ""),
                            ProfileItemWidget(
                                title: 'GST Number',
                                value: profileController.userProfileModel.value
                                        .user!.gstNumber ??
                                    ""),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => profileController.isLoading.value
              ? Container()
              : FloatingActionButton(
                  child: Image.asset(
                    AppIcons.editIcon,
                    height: 24,
                    width: 24,
                  ),
                  onPressed: () {
                    context.push(const EditProfileScreen()).then((value) {});
                  }),
        )
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
  }
}
