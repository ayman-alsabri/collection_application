import 'package:collection_application/app/views/home/drawer/widgets/drawer_item.dart';
import 'package:collection_application/app/views/resources/resources_screen_view.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});
  static  int? selectedItem;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DrawerItem(iconName: 'resources', title: 'مراجع مساعدة', index: 0, page: ResourcesScreenView())
      ],
      

    );
  }
}