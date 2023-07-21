import 'package:distech_technology/Commons/app_icons.dart';

class DrawerItemModel {
  final String label;
  final String icon;

  DrawerItemModel(this.label, this.icon);
}

final List<DrawerItemModel> drawerItemsList = [
  DrawerItemModel('Dashboard', AppIcons.dashboardIcon),
  //DrawerItemModel('My Profile', AppIcons.myProfileIcon),
  DrawerItemModel('Return Unsold Ticket', AppIcons.ticketIcon),
  DrawerItemModel('Sold Ticket', AppIcons.ticketIcon),
  DrawerItemModel('View Purchase History', AppIcons.purchaseHistoryIcon),
  DrawerItemModel('Support', AppIcons.supportIcon),
];
