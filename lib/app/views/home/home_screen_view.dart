import 'package:collection_application/app/globalControllers/dataController/data_controller.dart';
import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/app/views/home/bottomSheet/bottom_sheet_view.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/calories_buttom_container_view.dart';
import 'package:collection_application/app/views/home/drawer/my_drawer.dart';
import 'package:collection_application/app/views/home/widgets/custom_floating_action_button.dart';
import 'package:collection_application/custom/appBar/custom_app_bar.dart';
import 'package:collection_application/custom/button/grey_sqare_button.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers_controllers.dart';
import 'package:collection_application/templates/homeBackground/home_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});


  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    Get.put(ThreeSwipersControllers());
    Get.put(DataController());

    return HomeScreenTemplate(
      appBar: CustomAppbar(
        actionButtom: Builder(builder: (context) {
          return GreySqareButton(
            iconName: 'sideBar.png',
            padding: 12,
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
        title: 'تجميع البيانات',
        // leadingButtom: const BlueSqareButton(
        //   iconName: 'filter.png',
        //   padding: 12,
        // ),
      ),
      floatingActionButton: const CustomFloatingActionButton(
        bottomSheet: BottomSheetView(),
      ),
      drawer: const MyDrawer(),
      body: const Column(
        children: [
          ThreeSwipers(),
          Expanded(child: CaloriesButtomContainer()),
        ],
      ),
    );
  }
}
