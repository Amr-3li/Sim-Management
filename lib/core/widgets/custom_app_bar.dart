import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_management_task/core/utils/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.actions,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          }
        },
      ),
      title: Text.rich(
        TextSpan(
          text: title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          children: [
            if (subtitle != null)
              TextSpan(
                text: ' - $subtitle',
                style: const TextStyle(fontSize: 22, color: AppColors.infoText),
              ),
          ],
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
