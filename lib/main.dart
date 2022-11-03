import 'package:flutter/material.dart';
import 'package:loginapp/Themes.dart';
import 'package:loginapp/login_page.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyAppTheme,
      themeMode: MyThemeMode,
      home: const LoginPage(),
    );
  }
}
