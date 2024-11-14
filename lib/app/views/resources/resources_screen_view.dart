import 'package:collection_application/app/views/home/drawer/drawer_content.dart';
import 'package:collection_application/app/views/resources/bottomSection/bottom_container.dart';
import 'package:collection_application/custom/appBar/custom_app_bar.dart';
import 'package:collection_application/custom/button/blue_sqare_button.dart';
import 'package:collection_application/templates/containers/transparent_rrect_container.dart';
import 'package:collection_application/templates/homeBackground/home_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResourcesScreenView extends StatelessWidget {
  const ResourcesScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreenTemplate(
      appBar: CustomAppbar(
        title: 'مراجع مساعدة',
        actionButtom: BlueSqareButton(
          padding: 12,
          iconName: 'back.png',
          onPressed: () {
            DrawerContent.selectedItem = null;
            Get.back();
          },
        ),
      ),
      body: const Column(
        children: [
          TransparentRrectContainer(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'تجميع البيانات',
                    style: TextStyle(
                      fontFamily: 'TITR',
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '''تم تصميم هذا التطبيق ليكون منصة قيّمة تعتمد على بيانات دقيقة، تُبنى بسواعد نخبة من الموثوقين الذين يدركون أهمية الدقة والمسؤولية. 

نجاح المشروع بالكامل يعتمد على تفانيكم، فهو لن يحقق أهدافه إلا بجهودكم القيّمة.''',
                    style: TextStyle(
                      fontFamily: 'SF MADA',
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: BottomContainer())
        ],
      ),
    );
  }
}
