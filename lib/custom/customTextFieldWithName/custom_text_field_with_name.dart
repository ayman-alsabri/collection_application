import 'package:collection_application/custom/customTextFieldWithName/custom_text_field_with_name_controller.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFieldWithName extends StatelessWidget {
  final String name;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool isPassword;
  final TextInputType? keyboardType;
  const CustomTextFieldWithName(
      {super.key,
      required this.name,
      this.isPassword = false,
      this.onSubmitted,
      this.onChanged,
      this.onTap,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomTextFieldWithNameController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Text(
              name,
              style: const TextStyle(fontFamily: 'SF MADA'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (!isPassword)
          TextField(
            onTapOutside: (event) => Get.focusScope?.unfocus(),
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            onTap: onTap,
            keyboardType: keyboardType,
            style: const TextStyle(fontFamily: 'TITR'),
            decoration: InputDecoration(
              filled: true, // Enables background color
              fillColor: textFieldBackgroundColor,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20.0), // Padding inside the TextField
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
                borderSide: BorderSide.none, // No border line
              ),
            ),
          ),
        if (isPassword)
          Obx(() {
            return TextField(
              onTapOutside: (event) => Get.focusScope?.unfocus(),
              onSubmitted: onSubmitted,
              onChanged: onChanged,
              onTap: onTap,
              keyboardType: keyboardType,
              obscureText: (isPassword && controller.hideText.value),
              style: const TextStyle(fontFamily: 'TITR'),
              decoration: InputDecoration(
                suffixIcon: isPassword
                    ? IconButton(
                        highlightColor: AppTheme.appTheme.colorScheme.onPrimary
                            .withOpacity(0.04),
                        color: AppTheme.appTheme.colorScheme.onPrimary
                            .withOpacity(0.6),
                        onPressed: controller.toggleTextAppearance,
                        icon: Icon(controller.hideText.value
                            ? Icons.visibility
                            : Icons.visibility_off))
                    : null,
                filled: true, // Enables background color
                fillColor: textFieldBackgroundColor,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20.0), // Padding inside the TextField
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners
                  borderSide: BorderSide.none, // No border line
                ),
              ),
            );
          }),
      ],
    );
  }
}
