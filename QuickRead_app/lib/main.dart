import 'package:flutter/material.dart';
import 'package:quickread_app/Theme/dark_mode.dart';
import 'package:quickread_app/Theme/light_mode.dart';
import 'package:quickread_app/pages/bookmark_page.dart';
import 'package:quickread_app/pages/login_page.dart';
import 'package:quickread_app/pages/news_page.dart';

void main() async {
  runApp(const QuickRead());
}

class QuickRead extends StatefulWidget {
  const QuickRead({super.key});

  @override
  State<QuickRead> createState() => _QuickReadState();
}

class _QuickReadState extends State<QuickRead> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      title: 'News App',
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login': (context) => LoginPage(),
        '/news': (context) => NewsPage(),
        '/bookmarks': (context) => BookmarkPage(),
      },
    );
  }
}
