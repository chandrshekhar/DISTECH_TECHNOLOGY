import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Features/Profile/Presentation/edit_profile_screen.dart';
import 'package:distech_technology/Features/Profile/Widgets/profile_item_widget.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:easy_localization/easy_localization.dart';
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
    profileController.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'myProfile',
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
                        backgroundImage: AssetImage(
                            "assets/images/blank-profile-picture.webp"),
                        maxRadius: 60,
                        minRadius: 60,
                      ),
                    ),
                  )
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
                                title: 'userId',
                                value: profileController.userProfileModel.value
                                        .user?.userName ??
                                    "NA"),
                            ProfileItemWidget(
                                title: 'fullName',
                                value: profileController.userProfileModel.value
                                        .user?.fullName ??
                                    "NA"),
                            //const ProfileItemWidget(title: 'Last Name', value: 'Paul'),
                            ProfileItemWidget(
                                title: 'adharId',
                                value: profileController.userProfileModel.value
                                        .user?.aadhaarId ??
                                    "NA"),
                            ProfileItemWidget(
                                title: 'panNumber',
                                value: profileController.userProfileModel.value
                                        .user?.panNumber ??
                                    "NA"),
                            ProfileItemWidget(
                                title: 'address1',
                                value: profileController.userProfileModel.value
                                                .user!.address1 !=
                                            null &&
                                        profileController.userProfileModel.value
                                            .user!.address1!.isEmpty
                                    ? 'NA'
                                    : '${profileController.userProfileModel.value.user?.address1}\n${profileController.userProfileModel.value.user?.address2}'),
                            ProfileItemWidget(
                                title: 'pinCode',
                                value: profileController
                                        .userProfileModel.value.user?.pinCode ??
                                    "NA"),
                            SizedBox(
                              height: AppSizes.kDefaultPadding,
                            ),
                            Text(
                              'otherInformation'.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color:
                                          AppColors.darkGrey.withOpacity(0.8)),
                            ).tr(),
                            SizedBox(
                              height: AppSizes.kDefaultPadding / 2,
                            ),
                            const CustomDivider(),
                            SizedBox(
                              height: AppSizes.kDefaultPadding,
                            ),
                            ProfileItemWidget(
                                title: 'mobileNumber',
                                value: profileController.userProfileModel.value
                                        .user?.mobileNumber ??
                                    "NA"),
                            ProfileItemWidget(
                                title: 'emailId',
                                value: profileController
                                        .userProfileModel.value.user?.email ??
                                    "NA"),
                            ProfileItemWidget(
                                title: 'tradeLicenseNumber',
                                value: profileController.userProfileModel.value
                                        .user?.tradeLicenseNumber ??
                                    "NA"),
                            ProfileItemWidget(
                                title: 'gstNumber',
                                value: profileController.userProfileModel.value
                                        .user?.gstNumber ??
                                    "NA"),
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
