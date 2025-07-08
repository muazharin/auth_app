import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

class ButtonDefault extends StatelessWidget {
  const ButtonDefault({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    this.radius = 12,
    this.textSize = 16,
    this.icon,
  });
  final String? text;
  final Color? color;
  final double? textSize;
  final double? radius;
  final Widget? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: Row(
          children: [
            icon ?? const SizedBox(),
            Expanded(
              child: Center(
                child: Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                  style: textBold.copyWith(
                    color: Colors.white,
                    fontSize: textSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
