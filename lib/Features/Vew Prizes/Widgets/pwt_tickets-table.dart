import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Features/Vew%20Prizes/Controller/prize_controller.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

// ignore: must_be_immutable
class PwtDataTable extends StatelessWidget {
  PwtDataTable({Key? key, required this.prizesController}) : super(key: key);
  PrizesController prizesController;

  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      leftHandSideColumnWidth: 0,
      rightHandSideColumnWidth: 550,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: 20,
      // itemCount: documentsVaultController.documentVaultList.length,
      // rowSeparatorWidget: const Divider(
      //   color: Colors.black38,
      //   height: 1.0,
      //   thickness: 0.0,
      // ),

      leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      itemExtent: 40,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('', 0),
      _getTitleItemWidget('SL', 40),
      _getTitleItemWidget('TICKET', 120),
      _getTitleItemWidget('PRIZE', 120),
      _getTitleItemWidget('PRIZE AMOUNT', 130),
      _getTitleItemWidget('AGENT AMOUNT', 130),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 40,
      alignment: Alignment.center,
      color: AppColors.primary,
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container();
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Container(
      color: (index % 2 == 0) ? Colors.white : AppColors.primaryBg,
      padding: EdgeInsets.symmetric(
        vertical: (index % 2 != 0) ? 4 : 0,
      ),
      child: Row(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              height: 25,
              width: 40,
              child: Text(
                "${index + 1}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.darkGrey, fontWeight: FontWeight.w500),
              )),
          Container(
              width: 120,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                "AA - AD 05174",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.darkGrey.withOpacity(0.8),
                    fontWeight: FontWeight.w500),
              )),
          Container(
            width: 120,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              "Third Prize",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.darkGrey.withOpacity(0.8),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            width: 120,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              "₹12,000.00",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.darkGrey.withOpacity(0.8),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            width: 120,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              "	₹12,000.00",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.darkGrey.withOpacity(0.8),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
