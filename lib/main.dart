import "package:flutter/material.dart";

import 'pages/photos_api_page.dart';
import 'pages/home_page.dart';
import "pages/user_api_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    PhotosAPIPage(),
    UserAPIPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // function for changing the selected index
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My App",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("API practice"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Get API",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Photos API",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "User API",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber,
          onTap: (value) => _onItemTapped(value),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
