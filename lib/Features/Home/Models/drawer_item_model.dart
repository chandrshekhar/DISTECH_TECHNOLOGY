import 'package:distech_technology/Commons/app_icons.dart';

class DrawerItemModel {
  final String label;
  final String icon;

  DrawerItemModel(this.label, this.icon);
}

final List<DrawerItemModel> drawerItemsList = [
  DrawerItemModel('Dashboard', AppIcons.dashboardIcon),
  DrawerItemModel('Return Unsold Ticket', AppIcons.ticketIcon),
  DrawerItemModel('Sold Ticket', AppIcons.ticketIcon),
  DrawerItemModel('Returned Ticket', AppIcons.ticketIcon),
  DrawerItemModel('View Purchase History', AppIcons.purchaseHistoryIcon),
  DrawerItemModel('Verify Ticket', AppIcons.dashboardIcon),
  DrawerItemModel("New Claim", AppIcons.newClaimIcon),
  DrawerItemModel("My Claim", AppIcons.myClaimIcon),
  DrawerItemModel('Support', AppIcons.supportIcon),
  DrawerItemModel("Prize", AppIcons.filterIcon),
];

final List<DrawerItemModel> drawerItemsListNew = [
  DrawerItemModel('Dashboard', AppIcons.dashboardIcon),
  DrawerItemModel('Inventory', AppIcons.ticketIcon),
  DrawerItemModel('Sales', AppIcons.ticketIcon),
  DrawerItemModel('Unsold', AppIcons.ticketIcon),
  DrawerItemModel('Verify', AppIcons.purchaseHistoryIcon),
  DrawerItemModel('Claim', AppIcons.newClaimIcon),
  DrawerItemModel("Billing", AppIcons.newClaimIcon),
  DrawerItemModel('Support', AppIcons.supportIcon),
];
