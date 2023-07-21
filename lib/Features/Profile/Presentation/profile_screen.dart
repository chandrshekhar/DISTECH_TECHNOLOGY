import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/EditProfile/Presentation/edit_profile_screen.dart';
import 'package:distech_technology/Features/Profile/Widgets/profile_item_widget.dart';
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding),
              child: ListView(
                children: [
                  const ProfileItemWidget(title: 'First Name', value: 'Shuvra'),
                  const ProfileItemWidget(title: 'Last Name', value: 'Paul'),
                  const ProfileItemWidget(
                      title: 'Aadhaar ID', value: '0000 0000 0000'),
                  const ProfileItemWidget(
                      title: 'Pan Number', value: 'DAZKK2103N'),
                  const ProfileItemWidget(
                      title: 'Address 1',
                      value: 'ABCD Nagar, Block-A, Uttarayan, Bidhannagar'),
                  const ProfileItemWidget(title: 'PIN Code', value: '743437'),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  Text(
                    'Other Information'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.darkGrey.withOpacity(0.8)),
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding / 2,
                  ),
                  const CustomDivider(),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  const ProfileItemWidget(
                      title: 'Mobile Number', value: '6454356425'),
                  const ProfileItemWidget(
                      title: 'Email ID', value: 'user@gmail.com'),
                  const ProfileItemWidget(
                      title: 'Trade License Number', value: '123456789'),
                  const ProfileItemWidget(
                      title: 'GST Number', value: 'AGDF124563DG'),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Image.asset(
            AppIcons.editIcon,
            height: 24,
            width: 24,
          ),
          onPressed: () {
            context.push(const EditProfileScreen());
          }),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
