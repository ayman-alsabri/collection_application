import 'package:collection_application/app/globalControllers/responsive.dart';
import 'package:collection_application/custom/dialog/dialog_with_confirmation_only.dart';
import 'package:collection_application/helpers/r_rect_stroke_clipper.dart';
import 'package:collection_application/templates/dialog/general_dialog.dart';
import 'package:collection_application/theme/custom_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class GeneralBottomSheet extends StatefulWidget {
  final String firstButtonName;
  final String secondButtonName;
  final Widget firstField;
  final Widget secondField;
  final Future<void> Function(int index)? onTap;

  const GeneralBottomSheet({
    super.key,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.firstField,
    required this.secondField,
    this.onTap,
  });

  @override
  State<GeneralBottomSheet> createState() => _GeneralBottomSheetState();
}

class _GeneralBottomSheetState extends State<GeneralBottomSheet> {
  final _animationDuration = const Duration(milliseconds: 250);
  bool _animate = false;
  bool _canPop = false;
  int _focusedIndex = 0;

  Future<void> _onTap(int index) async {
    if (_animate) return;

    if (widget.onTap != null) {
      try {
        await widget.onTap!(index);
      } catch (e) {
        return;
      }
    }
    setState(() {
      _animate = true;
      _focusedIndex = index;
    });

    await Future.delayed(_animationDuration);

    setState(() {
      _animate = false;
    });
  }

  Future<void> _handlePopRequest() async {
    final result = await showGeneralDialog<bool>(
      useRootNavigator: true,
      context: context,
      transitionBuilder: GeneralDialog.transitionBuilder,
      transitionDuration: GeneralDialog.transitionDuration,
      pageBuilder: (ctx, animation, secondaryAnimation) =>
          DialogWithConfirmationOnly(
        title: 'هل تريد الخروج',
        cancelText: "لا",
        confirmText: "نعم",
        onConfirmed: () async =>
            Navigator.of(ctx, rootNavigator: true).pop(true),
        onCanceled: () async =>
            Navigator.of(ctx, rootNavigator: true).pop(false),
      ),
    );
    if (!mounted) return;

    if (result ?? false) {
      setState(() {
        _canPop = true;
      });

     WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>  Navigator.of(context).pop(),);
      return;
    }
    // Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult:
          _canPop ? null : (didPop, result) => _handlePopRequest(),
      child: SizedBox(
        height: Responsive.height(450),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  colors: [
                    gradientStartColor,
                    gradientEndColor,
                  ],
                  begin: Alignment(-0.63, -1.09),
                  end: Alignment(0, 0.191),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -20),
                      blurRadius: 40)
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _createButton(widget.firstButtonName, 0),
                        _createButton(widget.secondButtonName, 1),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        widget.firstField
                            .animate(target: _focusedIndex == 0 ? 1 : 0)
                            .moveX(
                                curve: Curves.easeInOut,
                                begin: Responsive.deviseWidth,
                                end: 0,
                                duration: _animationDuration),
                        widget.secondField
                            .animate(target: _focusedIndex == 1 ? 1 : 0)
                            .moveX(
                                curve: Curves.easeInOut,
                                begin: -Responsive.deviseWidth,
                                end: 0,
                                duration: _animationDuration),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ClipPath(
              clipper: RRectStrokeClipper(borderRadius: 30, strokeWidth: 4),
              child: Container(
                width: double.maxFinite,
                height: Responsive.height(100),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  strokeGradientStartColor.withOpacity(0.1),
                  Colors.transparent
                ], begin: const Alignment(0, -1), end: const Alignment(0, 1))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createButton(String buttonName, int index) {
    bool isFocused = _focusedIndex == index;

    final elevatedShadows = [
      BoxShadow(
          color: elevatedButtonTopShadow.withOpacity(1),
          offset: const Offset(-3, -3),
          blurRadius: 6),
      BoxShadow(
          color: Colors.black.withOpacity(0.5),
          offset: const Offset(3, 3),
          blurRadius: 6),
      const BoxShadow(color: elevatedButtonColor),
    ];
    final cravedShadows = [
      const BoxShadow(
          color: cravedButtonButtomShadow, offset: Offset(2, 2), blurRadius: 1),
      const BoxShadow(color: cravedButtonTopShadow),
      const BoxShadow(
          color: cravedButtonColor,
          offset: Offset(1.5, 1.5),
          spreadRadius: -0.5,
          blurRadius: 2),
    ];

    return InkWell(
      splashColor: Colors.transparent,
      onTap: isFocused ? null : () => _onTap(index),
      child: AnimatedContainer(
        width: (Responsive.deviseWidth / 2) - 32 - 32,
        height: Responsive.height(43),
        duration: _animationDuration,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: isFocused ? cravedShadows : elevatedShadows,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            index == 0 ? widget.firstButtonName : widget.secondButtonName,
            style: TextStyle(
                fontFamily: 'TITR', fontSize: Responsive.width(15), height: 2),
          ).animate(target: isFocused ? 1 : 0).custom(
            builder: (context, value, child) {
              final color1 = ColorTween(
                      begin: bluegradientStartColor,
                      end: Colors.white.withOpacity(0.6))
                  .transform(value)!;
              final color2 = ColorTween(
                      begin: bluegradientEndColor,
                      end: Colors.white.withOpacity(0.6))
                  .transform(value)!;

              return ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                        colors: [color1, color2],
                        begin: const Alignment(-1, 0),
                        end: const Alignment(1, 0),
                      ).createShader(bounds),
                  child: child);
            },
          ),
        ),
      ),
    );
  }
}
