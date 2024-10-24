import 'package:collection_application/globalControllers/authController/responsive.dart';
import 'package:flutter/material.dart';

class AuthScreenTemp extends StatelessWidget {
  final Widget body;
  final void Function()? onPressed;
  const AuthScreenTemp({super.key, required this.body, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.instanse;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: onPressed),
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 0,
            top: responsive.height(106),
            child: responsive.withHeightPercentage(
              200 / 844,
              Container(height: responsive.height(200),
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
            top: responsive.height(388),
            child: responsive.withHeightPercentage(
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
