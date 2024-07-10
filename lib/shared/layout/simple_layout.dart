import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:randomize_me/provider/theme-provider.dart';
import 'package:randomize_me/shared/Texts/themes.dart';

import '../elements/BottomNav.dart';

class SimpleLayout extends StatelessWidget {
  final Widget layout;
  final String title;
  final AppBar? customAppBar;

  const SimpleLayout(
      {Key? key, required this.layout, required this.title, this.customAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: customAppBar ??
          AppBar(
              title: Text(title),
              actions: [
                IconButton(
                    onPressed: () => {themeProvider.changeTheme()},
                    icon: themeProvider.themeDataStyle == lightTheme
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.sunny)),
              ],
              titleTextStyle: const TextStyle(color: Colors.white)),
              bottomNavigationBar: const BottomNav(),
              body: layout,
    );
  }
}
