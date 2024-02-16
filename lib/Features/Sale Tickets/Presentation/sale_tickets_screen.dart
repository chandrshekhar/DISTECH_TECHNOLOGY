import 'dart:developer';

import 'package:distech_technology/Api/api_provider.dart';
import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:distech_technology/Features/Sale%20Tickets/Controller/sale_tickets_controller.dart';
import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:distech_technology/Widgets/custom_divider.dart';
import 'package:distech_technology/Widgets/custom_text_field.dart';
import 'package:distech_technology/Widgets/full_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Controller/Ticket Controller/sold_ticket_controller.dart';
import '../../ReturnUnsoldTicket/Presentation/return_unsold_ticket_screen.dart';
import '../Widgets/scanner_card.dart';

class SaleTicketsScreen extends StatelessWidget {
  SaleTicketsScreen({super.key});

  final saleTicketController = Get.put(SaleTicketsController());
  final soldTicketController = Get.put(SoldTicketController());

  // focus node for moving next field
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  height: MediaQuery.of(context).size.height * 0.05,
                  readOnly: true,
                  onTap: () async {
                    saleTicketController.fromDateController.value.text =
                        await selectDate(context) ?? "";
                  },
                  controller: saleTicketController.fromDateController.value,
                  suffixIcon: const Icon(Icons.date_range),
                )),
                const SizedBox(width: 10),
                Expanded(
                    child: CustomTextField(
                  height: MediaQuery.of(context).size.height * 0.05,
                  readOnly: true,
                  controller: saleTicketController.toDateController.value,
                  onTap: () async {
                    saleTicketController.toDateController.value.text =
                        await selectDate(context) ?? "";
                  },
                  suffixIcon: const Icon(Icons.date_range),
                )),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Obx(() => Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                            saleTicketController.isScanningTicket.value
                                ? AppColors.lightGrey
                                : AppColors.primary,
                          )),
                          onPressed: () {
                            saleTicketController.isScanningTicketsMethod(false);
                          },
                          child: const Text("Manul Entry")),
                    )),
                const SizedBox(width: 10),
                Expanded(
                    child: Obx(() => ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          !saleTicketController.isScanningTicket.value
                              ? AppColors.lightGrey
                              : AppColors.primary,
                        )),
                        onPressed: () {
                          saleTicketController.isScanningTicketsMethod(true);
                        },
                        child: const Text("Scan Ticket"))))
              ],
            ),
            Obx(() => saleTicketController.isScanningTicket.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: scanCode(context),
                  )
                : manulField(context)),
            const SizedBox(height: 5),
            Obx(() => FullButton(
                  label: 'Mark sold',
                  bgColor: saleTicketController.successReturnTicketList.isEmpty
                      ? AppColors.lightGrey
                      : AppColors.primary,
                  onPressed: saleTicketController
                          .successReturnTicketList.isEmpty
                      ? () {}
                      : () async {
                          if (saleTicketController
                              .successReturnTicketList.isNotEmpty) {
                            var res = await ApiProvider().soldTciket(
                                saleTicketController.successReturnTicketList);
                            log("pandey---> ${res.toString()}");
                            if (res['success'] &&
                                res['successList'].length > 0) {
                              Get.snackbar("Successful",
                                  res['successList'][0]['message'].toString(),
                                  backgroundColor: AppColors.white,
                                  colorText: Colors.green,
                                  isDismissible: true,
                                  snackPosition: SnackPosition.TOP);
                              saleTicketController.successReturnTicketList
                                  .clear();
                            } else {
                              Get.snackbar("Error!",
                                  res['failedList'][0]["message"].toString(),
                                  backgroundColor: AppColors.white,
                                  colorText: Colors.red,
                                  isDismissible: true,
                                  snackPosition: SnackPosition.TOP);
                            }

                            await soldTicketController.getAllTicket(
                              date: soldTicketController.formatedDate.value,
                            );
                            soldTicketController.limit.value =
                                soldTicketController.limit.value;
                            soldTicketController.selectedSoldTicket.clear();
                          } else {
                            Get.snackbar("Not response",
                                "Your are not selected any ticket for mark as sold",
                                backgroundColor: AppColors.black,
                                colorText: Colors.white,
                                isDismissible: true,
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                )),
          ],
        ),
      ),
    );
  }

  Widget scanCode(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Expanded(
                  child: ScannerCardWidget(
                    onTap: () async {
                      saleTicketController.scanBarCode(true);
                    },
                    title: "From Tickets",
                    subTitle: saleTicketController.fromTickets.value,
                  ),
                )),
            const SizedBox(width: 10),
            Obx(() => Expanded(
                  child: ScannerCardWidget(
                    onTap: () {
                      saleTicketController.scanBarCode(false);
                    },
                    title: "To Tickets",
                    subTitle: saleTicketController.toTickets.value,
                  ),
                )),
            const SizedBox(width: 5),
            Obx(
              () => InkWell(
                onTap: saleTicketController.fromTickets.value.isNotEmpty &&
                        saleTicketController.toTickets.value.isNotEmpty
                    ? () {
                        saleTicketController.validateSalesTickets(
                          fromNumber: int.parse(saleTicketController
                              .fromTickets.value
                              .substring(2, 7)),
                          toNumber: int.parse(saleTicketController
                              .toTickets.value
                              .substring(2, 7)),
                          fromLetter1:
                              saleTicketController.fromTickets.value[0],
                          fromLetter2:
                              saleTicketController.fromTickets.value[1],
                          toLetter1: saleTicketController.toTickets.value[0],
                          toLetter2: saleTicketController.toTickets.value[1],
                        );
                      }
                    : null,
                child: Container(
                    margin: const EdgeInsets.only(right: 2),
                    width: AppSizes.buttonHeight,
                    height: MediaQuery.of(context).size.height * 0.055,
                    decoration: BoxDecoration(
                        color: saleTicketController
                                    .fromTickets.value.isNotEmpty &&
                                saleTicketController.toTickets.value.isNotEmpty
                            ? AppColors.primary
                            : AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius / 2),
                        border: Border.all(color: AppColors.bg)),
                    child: saleTicketController.isTicketValidating == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          )),
              ),
            )
          ],
        ),
        manulField(context)
      ],
    );
  }

  Widget manulField(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: saleTicketController.isScanningTicket.value
            ? MediaQuery.of(context).size.height * 0.40
            : MediaQuery.of(context).size.height * 0.47,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.primaryBg,
        borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius / 2),
        border: Border.all(color: AppColors.bg),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'F.L.',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkGrey.withOpacity(0.8),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      'T. L.',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.darkGrey.withOpacity(0.8),
                          fontWeight: FontWeight.w500),
                    )),
                Expanded(
                  flex: 2,
                  child: Text(
                    'From No.',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkGrey.withOpacity(0.8),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '     To No.',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkGrey.withOpacity(0.8),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  'Add',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.darkGrey.withOpacity(0.8),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          //  const CustomDivider(),
          Obx(
            () => saleTicketController.isScanningTicket.value
                ? const SizedBox.shrink()
                : Row(children: [
                    Expanded(
                        flex: 2,
                        child: inputField(
                          readOnly: false,
                          context: context,
                          controller:
                              saleTicketController.fromLetterController.value,
                          onChanged: (v) {
                            saleTicketController.buttonEnabled();
                            if (v.toString().length == 2) {
                              saleTicketController.moveNextFieldChar();
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            UpperCaseTextFormatter(),
                          ],
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.characters,
                        )),
                    Expanded(
                        flex: 2,
                        child: inputField(
                          controller:
                              saleTicketController.toLetterController.value,
                          readOnly: false,
                          context: context,
                          onChanged: (v) {
                            saleTicketController.buttonEnabled();
                            if (v.toString().length == 2) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            UpperCaseTextFormatter(),
                          ],
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.characters,
                        )),
                    Obx(() => Expanded(
                        flex: 2,
                        child: inputField(
                          controller:
                              saleTicketController.fromNumberController.value,
                          focusNode: focus2,
                          readOnly: false,
                          context: context,
                          onChanged: (v) {
                            saleTicketController.buttonEnabled();

                            if (v.toString().length == 5) {
                              saleTicketController.moveNumberNext();
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.characters,
                        ))),
                    Obx(
                      () => Expanded(
                          flex: 2,
                          child: inputField(
                            controller:
                                saleTicketController.toNumberController.value,
                            readOnly: false,
                            context: context,
                            focusNode: focus3,
                            onChanged: (v) {
                              saleTicketController.buttonEnabled();
                              if (v.toString().length == 5) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                            ],
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.characters,
                          )),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: saleTicketController.addButtonEnable.value
                            ? () {
                                saleTicketController.validateSalesTickets(
                                    fromNumber: int.parse(saleTicketController
                                        .fromNumberController.value.text),
                                    toNumber: int.parse(saleTicketController
                                        .toNumberController.value.text),
                                    fromLetter1: saleTicketController
                                        .fromLetterController.value.text[0],
                                    fromLetter2: saleTicketController
                                        .fromLetterController.value.text[1],
                                    toLetter1: saleTicketController
                                        .toLetterController.value.text[0],
                                    toLetter2:
                                        saleTicketController.toLetterController.value.text[1]);
                                saleTicketController.fromTickets.value = "";
                                saleTicketController.toTickets.value = "";
                              }
                            : null,
                        child: Container(
                            margin: const EdgeInsets.only(right: 2),
                            width: 40,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                                color:
                                    saleTicketController.addButtonEnable.value
                                        ? AppColors.primary
                                        : AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(
                                    AppSizes.cardCornerRadius / 2),
                                border: Border.all(color: AppColors.bg)),
                            child: saleTicketController.isTicketValidating ==
                                    true
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
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
            if (saleTicketController.successReturnTicketList.isEmpty) {
              return const Text("No Ticket for Sale.");
            } else if (saleTicketController.isTicketValidating.value == true) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              return addedListWidget();
            }
          })
        ],
      ),
    );
  }

  Widget addedListWidget() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: saleTicketController.successReturnTicketList.length,
          itemBuilder: (context, index) {
            var data = saleTicketController.successReturnTicketList[index];
            return Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.kDefaultPadding / 1.5),
              color: (index % 2 == 0) ? AppColors.white : AppColors.primaryBg,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
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
                        saleTicketController.removeValidateReturnTicket(index);
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

  Widget inputField(
      {BuildContext? context,
      List<TextInputFormatter>? inputFormatters,
      TextEditingController? controller,
      TextInputType? keyboardType,
      void Function(String)? onChanged,
      bool readOnly = false,
      TextCapitalization? textCapitalization,
      FocusNode? focusNode}) {
    return Container(
      height: MediaQuery.of(context!).size.height * 0.05,
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      child: TextField(
        scrollPadding: EdgeInsets.zero,
        onChanged: onChanged,
        readOnly: readOnly,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        controller: controller,
        textCapitalization: textCapitalization!,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
