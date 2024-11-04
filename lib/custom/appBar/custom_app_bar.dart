import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget actionButtom;
  final Widget? leadingButtom;
  final String title;
  const CustomAppbar({
    super.key,
    required this.actionButtom,
    required this.title,
    this.leadingButtom,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = Responsive.width(44);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0,left: 8,right: 8,bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: buttonSize,
              width: buttonSize,
              child: actionButtom,
            ),
            Text(title,style: TextStyle(fontFamily: 'TITR',fontSize: Responsive.width(24)),),
            SizedBox(
              height: buttonSize,
              width: buttonSize,
              child: leadingButtom,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(Responsive.deviseWidth, Responsive.height(44)+32);
}
