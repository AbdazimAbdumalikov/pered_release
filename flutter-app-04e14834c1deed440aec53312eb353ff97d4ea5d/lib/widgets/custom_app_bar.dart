import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool rootNavigator;
  final PreferredSizeWidget? bottom;
  final double height;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.bottom,
    this.height = 60,
    this.rootNavigator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: ProjectTextStyles.ui_20Medium,
      ),
      bottom: bottom,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/images/svg/arrow_back.svg",
          color: ColorPalette.black,
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: rootNavigator).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
