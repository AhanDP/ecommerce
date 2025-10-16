import 'package:flutter/material.dart';
import '../navigation/navigation.dart';
import '../utills/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final double? titleSize;
  final bool? canLeadBack;
  const CustomAppBar({super.key, required this.title, this.canLeadBack, this.titleSize});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Constants.appBarBgColor,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
          color: Constants.primaryTextColor,
          fontSize: titleSize ?? 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      leading: Visibility(
        visible: canLeadBack == true,
        child: IconButton(
          onPressed: () => Navigation.instance.goBack(args: true),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Constants.primaryTextColor,
            size: 18,
          ),
        ),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
