import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/Profile/Presentation/edit_profile_screen.dart';
import 'package:distech_technology/Features/Profile/Widgets/profile_item_widget.dart';
import 'package:distech_technology/Features/Profile/model/profile_model.dart';
import 'package:distech_technology/Utils/app_helper.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Widgets/custom_shape_clipper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Variable Declarations
  ApiProvider apiProvider = ApiProvider();
  UserProfileModel? userProfileModel;
  bool isLoading = true;
// get all Ticket
  void getUserDetails() async {
    var res = await apiProvider.getUserDetails();
    setState(() {
      userProfileModel = res;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Profile',
      ),
      body: Column(
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
                    foregroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=2000'),
                  ))
            ],
          ),
          const SizedBox(
            height: AppSizes.kDefaultPadding,
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.kDefaultPadding),
                    child: ListView(
                      children: [
                        ProfileItemWidget(
                            title: 'Full Name',
                            value: userProfileModel!.user!.fullName ?? ""),
                        //const ProfileItemWidget(title: 'Last Name', value: 'Paul'),
                        ProfileItemWidget(
                            title: 'Aadhaar ID',
                            value: userProfileModel!.user!.aadhaarId ?? ""),
                        ProfileItemWidget(
                            title: 'Pan Number',
                            value: userProfileModel!.user!.panNumber ?? ""),
                        ProfileItemWidget(
                            title: 'Address 1',
                            value:
                                '${userProfileModel!.user!.address1}\n${userProfileModel!.user!.address2}'),
                        ProfileItemWidget(
                            title: 'PIN Code',
                            value: userProfileModel!.user!.pinCode ?? ""),
                        const SizedBox(
                          height: AppSizes.kDefaultPadding,
                        ),
                        Text(
                          'Other Information'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColors.darkGrey.withOpacity(0.8)),
                        ),
                        const SizedBox(
                          height: AppSizes.kDefaultPadding / 2,
                        ),
                        const CustomDivider(),
                        const SizedBox(
                          height: AppSizes.kDefaultPadding,
                        ),
                        ProfileItemWidget(
                            title: 'Mobile Number',
                            value: userProfileModel!.user!.mobileNumber ?? ""),
                        ProfileItemWidget(
                            title: 'Email ID',
                            value: userProfileModel!.user!.email ?? ""),
                        ProfileItemWidget(
                            title: 'Trade License Number',
                            value: userProfileModel!.user!.tradeLicenseNumber ??
                                ""),
                        ProfileItemWidget(
                            title: 'GST Number',
                            value: userProfileModel!.user!.gstNumber ?? ""),
                      ],
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: isLoading
          ? Container()
          : FloatingActionButton(
              child: Image.asset(
                AppIcons.editIcon,
                height: 24,
                width: 24,
              ),
              onPressed: () {
                context
                    .push(EditProfileScreen(
                  firstName: userProfileModel!.user!.fullName ?? "",
                  mobileNumber: userProfileModel!.user!.mobileNumber ?? "",
                  aadhaarId: userProfileModel!.user!.aadhaarId ?? "",
                  address:
                      '${userProfileModel!.user!.address1}',
                  emailAddress: userProfileModel!.user!.email ?? "",
                  gstNo: userProfileModel!.user!.gstNumber ?? "",
                  lincenseNo: userProfileModel!.user!.tradeLicenseNumber ?? "",
                  pinCode: userProfileModel!.user!.pinCode ?? "",
                ))
                    .then((value) {
                  setState(() {
                    getUserDetails();
                  });
                });
              }),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
