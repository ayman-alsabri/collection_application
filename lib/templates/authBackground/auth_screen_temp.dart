import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:flutter/material.dart';

class AuthScreenTemp extends StatelessWidget {
  final Widget body;
  const AuthScreenTemp({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 0,
            top: Responsive.height(106),
            child: Responsive.withHeightPercentage(
              200 / 844,
              Container(
                height: Responsive.height(200),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/background/auth/rightSection.png'),
                        fit: BoxFit.contain,
                        alignment: Alignment.centerLeft)),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: Responsive.height(388),
            child: Responsive.withHeightPercentage(
              370 / 844,
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/background/auth/leftSection.png'),
                        fit: BoxFit.contain,
                        alignment: Alignment.centerRight)),
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
