import 'package:collection_application/app/views/resources/bottomSection/resourse_class.dart';
import 'package:collection_application/custom/button/completeButtons/text_icon_press_button.dart';
import 'package:collection_application/custom/snackBar/custom_snack_bar.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceTile extends StatefulWidget {
  final Resourse resourse;
  const ResourceTile({super.key, required this.resourse});

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<ResourceTile> {
  bool _isLoading = false;
  Future<void> _onTap() async {
    final url = Uri.parse(widget.resourse.link);
    setState(() {
      _isLoading = true;
    });
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showCustomSnackBar(
          'لا يمكن فتح الرابط', "تأكد من الاتصال بالانترنت ثم حاول مرة أخرى");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: shadowColor.withOpacity(0.3),
      ),
      margin: const EdgeInsets.only(top: 0, bottom: 8, left: 16, right: 16),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.resourse.name,
                  style: const TextStyle(
                    fontFamily: 'TITR',
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.resourse.description,
                    softWrap: true,
                    style: const TextStyle(
                      fontFamily: 'SF MADA',
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          TextIconPressButton(
            iconName: 'launchLink.png',
            text: 'الرابط',
            onPressed: _isLoading ? null : _onTap,
          )
        ],
      ),
    );
  }
}
