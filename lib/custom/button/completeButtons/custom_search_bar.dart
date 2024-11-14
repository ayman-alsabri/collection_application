import 'package:collection_application/custom/button/blue_sqare_button.dart';
import 'package:collection_application/templates/containers/carved_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function() onPressed;
  final TextEditingController textController;

  const CustomSearchBar({
    super.key,
    required this.onPressed,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return CarvedContainer(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: TextField(
            onTapOutside: (event) => Get.focusScope?.unfocus(),
            controller: textController,
            style: const TextStyle(fontFamily: 'TITR'),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          )),
          BlueSqareButton(
            shadows: null,
            iconName: 'search.png',
            padding: 12,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
