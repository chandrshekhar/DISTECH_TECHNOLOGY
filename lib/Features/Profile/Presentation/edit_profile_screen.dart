import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/Profile/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../../Commons/app_colors.dart';
import '../../../Widgets/custom_shape_clipper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Edit Profile',
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                    height: 130,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).primaryColor),
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
                ),
              )
            ],
          ),
          SizedBox(
            height: AppSizes.kDefaultPadding,
          ),
          Expanded(
            child: Obx(
              () => ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
                children: [
                  CustomTextField(
                    controller: profileController.firstNameController.value,
                    hintText: 'Please enter name',
                    labelText: 'First Name',
                    isBorder: false,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    minLines: 1,
                  ),

                  // const SizedBox(
                  //   height: AppSizes.kDefaultPadding,
                  // ),
                  // CustomTextField(
                  //   controller: _lastNameController,
                  //   hintText: 'Paul',
                  //   keyboardType: TextInputType.name,
                  //   labelText: 'Last Name',
                  //   isBorder: false,
                  //   maxLines: 1,
                  //   minLines: 1,
                  // ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.addharController.value,
                    hintText: 'Enter aadhaar id',
                    labelText: 'Aadhaar ID',
                    keyboardType: TextInputType.number,
                    isBorder: false,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.addressController.value,
                    hintText: 'Please enter address',
                    labelText: 'Address',
                    isBorder: false,
                    keyboardType: TextInputType.streetAddress,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.pincodeController.value,
                    hintText: 'Enter pincode',
                    labelText: 'PIN Code',
                    isBorder: false,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding * 2,
                  ),
                  Text(
                    'Other Information'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.darkGrey.withOpacity(0.8)),
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding / 2,
                  ),
                  const CustomDivider(),
                  SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.mobileControlelr.value,
                    hintText: 'Please Enter Mobile Number',
                    labelText: 'Mobile Number',
                    keyboardType: TextInputType.number,
                    isBorder: false,
                    maxLength: 10,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.emailComtroller.value,
                    hintText: 'Please enter email',
                    labelText: 'Email ID',
                    keyboardType: TextInputType.emailAddress,
                    isBorder: false,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.tradeLicenceController.value,
                    hintText: "Please enter trade license",
                    labelText: 'Trade License Number',
                    isBorder: false,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.gstController.value,
                    hintText: 'Please Enter GST',
                    keyboardType: TextInputType.text,
                    labelText: 'GST Number',
                    isBorder: false,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  profileController.isUserDataSave.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : FullButton(
                          label: "Save",
                          onPressed: () async {
                            await profileController.editProfile(context);
                          }),
                  SafeArea(
                    child: SizedBox(
                      height: AppSizes.kDefaultPadding,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
