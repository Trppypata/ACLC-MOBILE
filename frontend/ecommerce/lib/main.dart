
import 'package:ecommerce/views/home_view.dart';
import 'package:ecommerce/views/login_view.dart';
import 'package:ecommerce/views/register_view.dart';
// import 'package:ecommerce/screens/Onboarding.dart';
import 'package:ecommerce/screens/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  PrunApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeView(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home':(context) => HomeView(),
        '/onboarding': (context) => const Onboarding(),
        '/register': (context) => const RegisterScreen(),
     
      },
    );
  }
}
