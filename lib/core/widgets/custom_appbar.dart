import 'package:flutter/material.dart';
import '../theme/theme_notifier.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// If true, shows the theme toggle icon on the app bar.
  final bool showThemeToggle;

  const CustomAppBar({super.key, this.showThemeToggle = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,

      //leading: Icon(Icons.phone_iphone),
      leading: Padding(
        padding: EdgeInsets.all(8),
        child: Image.asset(
          "assets/images/logo.png",
          width: 50,
          height: 50,
        ),
      ),

      title: Text(
        "Darapich Phone Shop",
        style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
      ),

      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.notifications, color: Theme.of(context).iconTheme.color),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        if (showThemeToggle)
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                icon: Icon(isDark ? Icons.dark_mode : Icons.wb_sunny_outlined, color: Theme.of(context).iconTheme.color),
                onPressed: () => themeNotifier.toggle(),
              );
            },
          ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CircleAvatar(child: Icon(Icons.person, color: Theme.of(context).iconTheme.color)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
