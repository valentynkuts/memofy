import 'package:flutter/material.dart';
import 'package:memofy/widgets/auth.dart';
import 'package:memofy/widgets/main_scrren/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => Auth(),
        '/main_screen': (context) => MainScreen(),
      },
    );
  }
}
