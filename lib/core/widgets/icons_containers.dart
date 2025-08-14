// icons_containers.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';

class IconsContainers extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String icon;
  final double? width2;
  final double? height2;

  const IconsContainers({
    super.key,
    required this.width,
    required this.height,
    this.color = AppColors.green,
    required this.icon,
    this.width2,
    this.height2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SvgPicture.asset(
        icon,
        width: width2,
        height: height2,
        fit: BoxFit.contain,
      ),
    );
  }
}