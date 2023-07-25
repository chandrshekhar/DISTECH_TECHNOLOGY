import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Controller/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Features/Profile/Presentation/profile_screen.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import '../../../Commons/app_colors.dart';
import '../../../Widgets/custom_shape_clipper.dart';

class EditProfileScreen extends StatefulWidget {
  

  const EditProfileScreen(
      {Key? key,
})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final profileController = Get.put(ProfileController());
  // //Variable Declarations
  // final TextEditingController _fullNameController = TextEditingController();
  // final TextEditingController _aadhaarIdController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  // final TextEditingController _pinCodeController = TextEditingController();
  // final TextEditingController _mobileNumberController = TextEditingController();
  // final TextEditingController _emailIdController = TextEditingController();
  // final TextEditingController _tradeLicencesController =
  //     TextEditingController();
  // final TextEditingController _gstNumberController = TextEditingController();

  
  @override
  void initState() {
    // TODO: implement initState
    // _fullNameController.text = widget.firstName;
    // _aadhaarIdController.text = widget.aadhaarId;
    // _addressController.text = widget.address;
    // _pinCodeController.text = widget.pinCode;
    // _mobileNumberController.text = widget.mobileNumber;
    // _emailIdController.text = widget.emailAddress;
    // _tradeLicencesController.text = widget.lincenseNo;
    // _gstNumberController.text = widget.gstNo;
    profileController.getUserDetails();
    super.initState();
  }

  

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
                  color: AppColors.primaryDark,
                ),
              ),
              const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.bg,
                    foregroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=2000'),
                  ))
            ],
          ),
          const SizedBox(
            height: AppSizes.kDefaultPadding,
          ),
          Expanded(
            child: Obx(()=>
               ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.kDefaultPadding),
                children: [
                  
                     CustomTextField(
                      controller: profileController.firstNameController.value,
                      hintText: 'Shuvra',
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
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.addharController.value,
                    hintText: '0000 0000 0000',
                    labelText: 'Aadhaar ID',
                    keyboardType: TextInputType.number,
                    isBorder: false,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.addressController.value,
                    hintText: 'ABCD Nagar, Block-A, Uttarayan, Bidhannagar ',
                    labelText: 'Address',
                    isBorder: false,
                    keyboardType: TextInputType.streetAddress,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.pincodeController.value,
                    hintText: '743437',
                    labelText: 'PIN Code',
                    isBorder: false,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding * 2,
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
                  CustomTextField(
                    controller: profileController.mobileControlelr.value,
                    hintText: '6535653542',
                    labelText: 'Mobile Number',
                    keyboardType: TextInputType.number,
                    isBorder: false,
                    maxLength: 10,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.emailComtroller.value,
                    hintText: 'user@gmail.com',
                    labelText: 'Email ID',
                    keyboardType: TextInputType.emailAddress,
                    isBorder: false,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.tradeLicenceController.value,
                    hintText: '123456789',
                    labelText: 'Trade License Number',
                    isBorder: false,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  CustomTextField(
                    controller: profileController.gstController.value,
                    hintText: '16365253454',
                    keyboardType: TextInputType.text,
                    labelText: 'GST Number',
                    isBorder: false,
                    maxLines: 1,
                    minLines: 1,
                  ),
                  const SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                  profileController.isUserDataSave.value
                      ? const CircularProgressIndicator.adaptive()
                      : FullButton(
                          label: "Save",
                          onPressed: () {
                           
                            profileController.editProfile(context);
                          }),
                  const SafeArea(
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
