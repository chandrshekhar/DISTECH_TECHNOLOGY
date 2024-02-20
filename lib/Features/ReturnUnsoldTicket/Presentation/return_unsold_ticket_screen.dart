import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Controller/Profile%20Controller/profile_controller.dart';
import 'package:distech_technology/Controller/Ticket%20Controller/sold_ticket_controller.dart';
import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:distech_technology/Features/ReturnUnsoldTicket/Model/return_tickets_response_model.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Api/api_provider.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Controller/Return Ticket Controller/return_ticket.dart';
import '../../../Utils/date_time_format.dart';
import '../../../Widgets/custom_divider.dart';

class ReturnUnsoldTicket extends StatefulWidget {
  const ReturnUnsoldTicket({Key? key}) : super(key: key);
  @override
  State<ReturnUnsoldTicket> createState() => _ReturnUnsoldTicketState();
}

class _ReturnUnsoldTicketState extends State<ReturnUnsoldTicket> {
  final soldTicketController = Get.put(SoldTicketController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  DateTime selectedDate = DateTime.now();
  String? formatedDate =
      formatDate(date: DateTime.now(), formatType: "yyyy-MM-dd");

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
        soldTicketzcontroller.getAllTicket(
            date: formatedDate,
            semNumber: soldTicketzcontroller.semNumber.value,
            search: soldTicketzcontroller.searchText.value);
        getMyreturnController.getAllReturnTicket(dateTime: formatedDate);
      });
    }
  }

  bool countLimit(bool selectedValue) {
    if (((getMyreturnController.returnCount.value -
                    soldTicketzcontroller.selectedSoldTicket.length) <=
                0 ||
            timerController.countdown.value == "0:00:00") &&
        selectedValue == true) {
      return false;
    }
    return true;
  }

  final soldTicketzcontroller = Get.put(SoldTicketController());
  final timerController = Get.put(TimerController());
  final profileController = Get.put(ProfileController());
  //Variable Declarations

  bool isSelected = false;
  final getMyreturnController = Get.put(GetMyReturnController());
  @override
  void initState() {
    super.initState();
    soldTicketzcontroller.selectedSoldTicket.clear();
    soldTicketzcontroller.getAllTicket();
    soldTicketzcontroller.searchText.value = '';
    soldTicketzcontroller.semNumber.value = 0;
    getMyreturnController.getAllReturnTicket();
    soldTicketController.dropDownValue.value = 10;
    soldTicketzcontroller.limit.value = 10;
    _selectDate(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  // focus node for moving next field
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Hide the onscreen keyboard on outside touch.
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.kDefaultPadding),
          child: Column(
            children: [
              // SizedBox(
              //   height: AppSizes.kDefaultPadding,
              // ),
              Container(
                height: AppSizes.buttonHeight,
                decoration: BoxDecoration(
                  color: AppColors.primaryBg,
                  borderRadius:
                      BorderRadius.circular(AppSizes.cardCornerRadius / 2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.kDefaultPadding / 2),
                        child: Text(
                          'You can return ${profileController.userProfileModel.value.user?.returnPercentage ?? 0}% of your total unsold tickets',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        height: AppSizes.buttonHeight,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(
                              AppSizes.cardCornerRadius / 2),
                        ),
                        child: Obx(() {
                          if (getMyreturnController
                              .isReturnTicketLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          }

                          return Text(
                              "${getMyreturnController.returnCount.value - getMyreturnController.validateTicketsList.length}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white));
                        }),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.all(AppSizes.kDefaultPadding / 1.5),
                          height: AppSizes.buttonHeight + 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppSizes.cardCornerRadius / 2),
                              border: Border.all(color: AppColors.bg)),
                          child: Image.asset(
                            AppIcons.calenderIcon,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.46,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSizes.cardCornerRadius / 2),
                      border: Border.all(color: AppColors.bg),
                    ),
                    child: Container(
                      color: AppColors.primaryBg,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'F.L.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'T. L.',
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: AppColors.darkGrey
                                                  .withOpacity(0.8),
                                              fontWeight: FontWeight.w500),
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'From No.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '     To No.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  'Add',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: AppColors.darkGrey
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          //  const CustomDivider(),
                          Obx(
                            () => Row(children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    textInputAction: TextInputAction.next,
                                    autofocus: true,
                                    onChanged: (v) {
                                      getMyreturnController.buttonEnabled();
                                      if (v.toString().length == 2) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    readOnly: timerController.countdown.value ==
                                            "0:00:00" ||
                                        getMyreturnController
                                                .returnCount.value ==
                                            0,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                      UpperCaseTextFormatter(),
                                    ],
                                    keyboardType: TextInputType.name,
                                    controller: getMyreturnController
                                        .fromLetterController.value,
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.blueGrey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (v) {
                                      getMyreturnController.buttonEnabled();
                                      if (v.toString().length == 2) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    readOnly: timerController.countdown.value ==
                                            "0:00:00" ||
                                        getMyreturnController
                                                .returnCount.value ==
                                            0,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                      UpperCaseTextFormatter()
                                    ],
                                    keyboardType: TextInputType.name,
                                    controller: getMyreturnController
                                        .toLetterController.value,
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.blueGrey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: TextField(
                                    onChanged: (v) {
                                      getMyreturnController.buttonEnabled();
                                      if (v.toString().length == 5) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    readOnly: timerController.countdown.value ==
                                            "0:00:00" ||
                                        getMyreturnController
                                                .returnCount.value ==
                                            0,
                                    focusNode: focus2,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(),
                                    controller: getMyreturnController
                                        .fromNumberController.value,
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.blueGrey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextField(
                                    onChanged: (v) {
                                      getMyreturnController.buttonEnabled();
                                      if (v.toString().length == 5) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    readOnly: timerController.countdown.value ==
                                            "0:00:00" ||
                                        getMyreturnController
                                                .returnCount.value ==
                                            0,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                    controller: getMyreturnController
                                        .toNumberController.value,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.blueGrey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: getMyreturnController
                                          .addButtonEnable.value
                                      ? () {
                                          getMyreturnController
                                              .validateReturnTicket(
                                                  "${profileController.userProfileModel.value.user!.sId}",
                                                  formatedDate ?? "");
                                          getMyreturnController.buttonEnabled();
                                        }
                                      : null,
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 2),
                                      width: AppSizes.buttonHeight,
                                      height: AppSizes.buttonHeight + 8,
                                      decoration: BoxDecoration(
                                          color: getMyreturnController
                                                  .addButtonEnable.value
                                              ? AppColors.primary
                                              : AppColors.lightGrey,
                                          borderRadius: BorderRadius.circular(
                                              AppSizes.cardCornerRadius / 2),
                                          border:
                                              Border.all(color: AppColors.bg)),
                                      child: getMyreturnController
                                                  .isTicketValidating ==
                                              true
                                          ? const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            )
                                          : const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            )),
                                ),
                              )
                            ]),
                          ),

                          const SizedBox(height: 5),
                          const CustomDivider(),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(() {
                            if (getMyreturnController
                                .validateTicketsList.isEmpty) {
                              return const Text("No Ticket for Return");
                            } else if (getMyreturnController
                                    .isReturnTicketLoading.value ==
                                true) {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            } else if (timerController.countdown.value ==
                                "0:00:00") {
                              return const Text("Return Time is Over");
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: getMyreturnController
                                        .validateTicketsList.length,
                                    itemBuilder: (context, index) {
                                      var data = getMyreturnController
                                          .validateTicketsList[index];

                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                AppSizes.kDefaultPadding / 1.5),
                                        color: (index % 2 == 0)
                                            ? AppColors.white
                                            : AppColors.primaryBg,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  AppSizes.kDefaultPadding),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  data.fromLetter.toString(),
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  data.toLetter.toString(),
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  data.fromNumber.toString(),
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    data.toNumber.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.blue),
                                                  )),
                                              InkWell(
                                                onTap: () {
                                                  getMyreturnController
                                                      .removeValidateReturnTicket(
                                                          index);
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  radius: 10,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.kDefaultPadding * 2,
                  ),
                  SafeArea(
                    child: Obx(() => FullButton(
                          label: 'Return Unsold',
                          onPressed: (getMyreturnController
                                      .validateTicketsList.isEmpty ||
                                  timerController.countdown.value == "0:00:00")
                              ? () {}
                              : () async {
                                  if (getMyreturnController
                                      .validateTicketsList.isNotEmpty) {
                                    var res = await ApiProvider()
                                        .retunTicketUnsold(
                                            getMyreturnController
                                                .validateTicketsList,
                                            formatedDate!,
                                            profileController.userProfileModel
                                                .value.user!.sId!);
                                    if (res.success) {
                                      await getMyreturnController
                                          .getAllReturnTicket(
                                              dateTime: formatedDate);
                                      Get.snackbar(
                                          "Successful", "Ticket Return Success",
                                          backgroundColor: AppColors.white,
                                          colorText: Colors.green,
                                          isDismissible: true,
                                          snackPosition: SnackPosition.TOP);
                                      getMyreturnController.clearText();
                                      getMyreturnController.validateTicketsList
                                          .clear();
                                      getMyreturnController.validateTicketsList
                                          .value = res.failedSeriesList!;
                                      if (res.failedSeriesList!.isNotEmpty) {
                                        // ignore: use_build_context_synchronously
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return modelBottomSheet(res
                                                .failedSeriesList!); // Your custom widget with ListView.builder
                                          },
                                        );
                                      }

                                      // soldTicketzcontroller
                                      //     .selectedSoldTicket
                                      //     .clear();

                                      await soldTicketzcontroller.getAllTicket(
                                          date: formatedDate);
                                    } else {
                                      Get.snackbar(
                                          "Error", res.error.toString(),
                                          backgroundColor: AppColors.black,
                                          colorText: Colors.white,
                                          isDismissible: true,
                                          snackPosition: SnackPosition.TOP);
                                    }
                                  }
                                },
                          bgColor: (getMyreturnController
                                      .validateTicketsList.isEmpty ||
                                  timerController.countdown.value == "0:00:00")
                              ? AppColors.lightGrey
                              : AppColors.secondary,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget modelBottomSheet(List<FailedSeriesList> failedSeriesList) {
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      height: 300,
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "These Tickets are alredy sold please clear It.",
                  style: TextStyle(color: AppColors.secondary, fontSize: 22),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    getMyreturnController.validateTicketsList.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("delete"))
            ],
          ),
          const SizedBox(height: 20),
          const CustomDivider(),
          SizedBox(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: failedSeriesList.length,
                itemBuilder: (context, index) {
                  var data = failedSeriesList[index];
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: AppSizes.kDefaultPadding / 1.5),
                    color: (index % 2 == 0)
                        ? AppColors.white
                        : AppColors.primaryBg,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.kDefaultPadding),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              data.fromLetter.toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              data.toLetter.toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              data.fromNumber.toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                data.toNumber.toString(),
                                style: const TextStyle(color: Colors.blue),
                              )),
                          InkWell(
                            onTap: () {
                              getMyreturnController
                                  .removeValidateReturnTicket(index);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 10,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
