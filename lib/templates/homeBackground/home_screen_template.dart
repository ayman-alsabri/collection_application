import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:flutter/material.dart';

class HomeScreenTemplate extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  const HomeScreenTemplate({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Responsive.withHeightPercentage(
              720.5 / 844,
              Container(
                height: Responsive.height(720.5),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background/home/homeBackground.png'),
                  fit: BoxFit.fill,
                )),
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
