import 'dart:ui';

import 'package:collection_application/app/views/home/drawer/drawer_content.dart';
import 'package:collection_application/app/views/home/drawer/drawer_footer.dart';
import 'package:collection_application/app/views/home/drawer/my_drawer_header.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                gradientStartColor.withOpacity(0.6),
                gradientEndColor.withOpacity(0.6)
              ],
              begin: const Alignment(-0.25, 0.25),
              end: const Alignment(0.25, 2.25),
            ),
          ),
          child: const Material(color: Colors.transparent,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 16, right: 16),
                    child: Column(
                      children: [
                        MyDrawerHeader(),
                        SizedBox(height: 32),
                        DrawerContent(),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Divider(),
                  DrawerFooter()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
