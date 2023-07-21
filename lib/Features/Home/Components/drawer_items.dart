// import 'package:distech_technology/Commons/app_colors.dart';
// import 'package:distech_technology/Commons/app_icons.dart';
// import 'package:distech_technology/Commons/app_images.dart';
// import 'package:distech_technology/Commons/app_sizes.dart';
// import 'package:distech_technology/Features/Home/Models/drawer_item_model.dart';
// import 'package:distech_technology/Features/Home/Presentation/home_screen.dart';
// import 'package:distech_technology/Features/Support/Presentation/support_screen.dart';
// import 'package:distech_technology/Utils/app_helper.dart';
// import 'package:distech_technology/Widgets/full_button.dart';
// import 'package:flutter/material.dart';
//
// import '../Widgets/drawer_item.dart';
//
// class DrawerItems extends StatelessWidget {
//   int selectedIndex;
//
//   DrawerItems({Key? key, required this.selectedIndex}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 width: 100,
//                 height: 100,
//                 padding: const EdgeInsets.only(
//                     top: AppSizes.kDefaultPadding / 3,
//                     left: AppSizes.kDefaultPadding / 3,
//                     bottom: AppSizes.kDefaultPadding * 2,
//                     right: AppSizes.kDefaultPadding * 2),
//                 margin: const EdgeInsets.only(
//                     top: AppSizes.kDefaultPadding,
//                     left: AppSizes.kDefaultPadding),
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage(
//                           AppImages.drawerLogoBg,
//                         ))),
//                 child: Image.asset(
//                   AppImages.drawerLogo,
//                   width: 30,
//                   fit: BoxFit.contain,
//                   height: 30,
//                 )),
//             const SizedBox(
//               height: AppSizes.kDefaultPadding,
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: drawerItemsList.length,
//                   shrinkWrap: false,
//                   itemBuilder: (context, index) {
//                     return DrawerItem(
//                       drawerItemModel: drawerItemsList[index],
//                     );
//                   }),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
//               child: FullButton(
//                 label: 'Logout',
//                 onPressed: () {},
//                 bgColor: AppColors.secondary,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                       child: Text('Developed By Excellis',
//                           style:
//                               Theme.of(context).textTheme.bodyMedium!.copyWith(
//                                     color: AppColors.darkGrey.withOpacity(0.7),
//                                   ))),
//                   Text(
//                     'App V0.1.1',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .copyWith(color: AppColors.darkGrey.withOpacity(0.7)),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
