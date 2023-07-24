import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/Profile/Presentation/profile_screen.dart';
import 'package:distech_technology/Widgets/custom_app_bar.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Commons/app_colors.dart';
import '../../../Widgets/custom_shape_clipper.dart';

class EditProfileScreen extends StatefulWidget {
  final String firstName;
  final String aadhaarId;
  final String address;
  final String pinCode;
  final String mobileNumber;
  final String emailAddress;
  final String lincenseNo;
  final String gstNo;

  const EditProfileScreen(
      {Key? key,
      required this.firstName,
      required this.aadhaarId,
      required this.address,
      required this.emailAddress,
      required this.mobileNumber,
      required this.gstNo,
      required this.lincenseNo,
      required this.pinCode})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //Variable Declarations
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _aadhaarIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _tradeLicencesController =
      TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();

  ApiProvider apiProvider = ApiProvider();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    _fullNameController.text = widget.firstName;
    _aadhaarIdController.text = widget.aadhaarId;
    _addressController.text = widget.address;
    _pinCodeController.text = widget.pinCode;
    _mobileNumberController.text = widget.mobileNumber;
    _emailIdController.text = widget.emailAddress;
    _tradeLicencesController.text = widget.lincenseNo;
    _gstNumberController.text = widget.gstNo;
    super.initState();
  }

  Future<void> editProfile() async {
    Map<String, dynamic> reqModel = {
      "fullName": _fullNameController.text,
      "aadhaarId": _aadhaarIdController.text,
      "panNumber": _mobileNumberController.text,
      "address1": _addressController.text,
      "address2": _addressController.text,
      "pinCode": _pinCodeController.text,
      "mobileNumber": _mobileNumberController.text,
      "tradeLicenseNumber": _tradeLicencesController.text,
      "gstNumber": _gstNumberController.text,
      "purchaseRateUs": "1133",
      "billRatePrice": "3311"
    };
    var res = await apiProvider.editProfile(reqModel);
    if (res == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text("Profile Update success fully")));
      // setState(() {
      //   isLoading = false;
      // });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
     
    }
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
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kDefaultPadding),
              children: [
                CustomTextField(
                  controller: _fullNameController,
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
                  controller: _aadhaarIdController,
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
                  controller: _addressController,
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
                  controller: _pinCodeController,
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
                  controller: _mobileNumberController,
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
                  controller: _emailIdController,
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
                  controller: _tradeLicencesController,
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
                  controller: _gstNumberController,
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
                isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : FullButton(
                        label: "Save",
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          editProfile();
                        }),
                const SafeArea(
                  child: SizedBox(
                    height: AppSizes.kDefaultPadding,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
