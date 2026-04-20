import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light().copyWith(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.light(
          primary: Colors.orange,
        ),
      ),

      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.orange,
        ),
        scaffoldBackgroundColor: const Color(0xff121212),
      ),

      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: HomeScreen(
        isDark: isDark,
        onToggleTheme: toggleTheme,
      ),
    );
  }
}