import 'package:flutter/material.dart';
import '../elements/BottomNav.dart';
class ResponsiveLayout extends StatelessWidget {
  final Widget phoneWidget;
  final Widget desktopWidget;
  final String title;
  const ResponsiveLayout({Key? key, required this.title, required this.phoneWidget, required this.desktopWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: const BottomNav(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return phoneWidget;
          } else {
            return desktopWidget;
          }
        },
      ),
    );
  }
}
