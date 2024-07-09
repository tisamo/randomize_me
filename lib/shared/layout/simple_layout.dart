import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../elements/BottomNav.dart';

class SimpleLayout extends StatelessWidget {
  final Widget layout;
  final String title;

  const SimpleLayout({Key? key, required this.layout, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.oswald(
          fontSize: 30,
          fontStyle: FontStyle.italic,
        ),
        bodyMedium: GoogleFonts.merriweather(),
        displaySmall: GoogleFonts.pacifico(),
      ),
    ),
      child: Scaffold(appBar: AppBar(
        backgroundColor: Colors.black, title: Text(title),
      ), bottomNavigationBar: const BottomNav(),
        body: layout,
      ),);
  }
}