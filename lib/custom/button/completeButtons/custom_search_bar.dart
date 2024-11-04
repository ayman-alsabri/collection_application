import 'package:collection_application/custom/button/blue_sqare_button.dart';
import 'package:collection_application/templates/containers/carved_container.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CarvedContainer(
      padding: EdgeInsetsDirectional.only(start: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: TextField(
            style: TextStyle(fontFamily: 'TITR'),
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          )),
          BlueSqareButton(
            shadows: null,
            iconName: 'search.png',
            padding: 12,
          )
        ],
      ),
    );
  }
}
