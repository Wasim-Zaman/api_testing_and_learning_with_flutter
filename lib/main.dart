import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

import "./pages/home_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: "My App",
      home: HomePage(),
    );
  }
}
