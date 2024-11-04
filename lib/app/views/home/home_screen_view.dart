import 'package:collection_application/app/views/home/bottomSheet/bottom_sheet_view.dart';
import 'package:collection_application/app/views/home/caloriesButtomSection/calories_buttom_container.dart';
import 'package:collection_application/app/views/home/widgets/custom_floating_action_button.dart';
import 'package:collection_application/custom/appBar/custom_app_bar.dart';
import 'package:collection_application/custom/button/blue_sqare_button.dart';
import 'package:collection_application/custom/button/completeButtons/custom_search_bar.dart';
import 'package:collection_application/custom/button/grey_sqare_button.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers.dart';
import 'package:collection_application/templates/homeBackground/home_screen_template.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  // TODO: Edit the elevated button to make the color blending

  @override
  Widget build(BuildContext context) {
    // late final controller = Get.put(ThreeSwipersControllers());
    return const HomeScreenTemplate(
      floatingActionButton: CustomFloatingActionButton(
        bottomSheet: BottomSheetView(),
      ),
      appBar: CustomAppbar(
        actionButtom: GreySqareButton(iconName: 'sideBar.png', padding: 12),
        title: 'تجميع البيانات',
        leadingButtom: BlueSqareButton(iconName: 'filter.png', padding: 12),
      ),
      body: Column(
        children: [
          ThreeSwipers(),
          CustomSearchBar(),
          Expanded(child: CaloriesButtomContainer()),
        ],
      ),
    );
  }
}
